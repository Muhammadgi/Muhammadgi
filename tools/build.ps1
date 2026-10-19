<#
.SYNOPSIS
  Rebuilds assets\banner.svg, assets\terminal.svg and assets\footer.svg from tools\config.js.

.DESCRIPTION
  Loads tools\build.html in headless Chrome or Microsoft Edge (already installed on most
  Windows PCs), collects the SVG markup that tools\generate.js produces, and writes it to
  ..\assets. No Node.js, Python or internet connection needed.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\build.ps1

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\build.ps1 -Browser "D:\Apps\chrome.exe"
#>
[CmdletBinding()]
param(
  # Optional path to chrome.exe / msedge.exe if it is not in a standard location.
  [string]$Browser
)

$ErrorActionPreference = 'Stop'
$tools  = $PSScriptRoot
$root   = Split-Path -Parent $tools
$assets = Join-Path $root 'assets'

$candidates = @(
  $Browser,
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }
$exe = $candidates | Select-Object -First 1
if (-not $exe) { throw 'Chrome or Edge was not found. Re-run with -Browser "<path to chrome.exe or msedge.exe>".' }

if (-not (Test-Path -LiteralPath $assets)) { New-Item -ItemType Directory -Path $assets | Out-Null }

$page    = ([System.Uri](Join-Path $tools 'build.html')).AbsoluteUri
$work    = Join-Path ([System.IO.Path]::GetTempPath()) ('profile-svg-build-' + [guid]::NewGuid().ToString('N'))
$domFile = Join-Path $work 'dom.html'
$errFile = Join-Path $work 'stderr.txt'
New-Item -ItemType Directory -Path $work | Out-Null

try {
  # Quote every argument: Start-Process joins them with spaces and paths may contain spaces.
  $argList = @(
    '--headless=new', '--disable-gpu', '--no-first-run', '--no-default-browser-check', '--disable-extensions',
    ('"--user-data-dir={0}"' -f (Join-Path $work 'profile')),
    '--dump-dom', ('"{0}"' -f $page)
  )
  Write-Host "Rendering with $exe"
  $proc = Start-Process -FilePath $exe -ArgumentList $argList -NoNewWindow -Wait -PassThru `
            -RedirectStandardOutput $domFile -RedirectStandardError $errFile

  $dom = [System.IO.File]::ReadAllText($domFile, [System.Text.Encoding]::UTF8)

  $failure = [regex]::Match($dom, '<script type="text/plain" id="out-error">([\s\S]*?)</script>')
  if ($failure.Success) { throw "tools\generate.js failed:`n$($failure.Groups[1].Value)" }

  $utf8NoBom = New-Object System.Text.UTF8Encoding $false
  foreach ($name in 'banner', 'terminal', 'footer') {
    $m = [regex]::Match($dom, '<script type="text/plain" id="out-' + $name + '">([\s\S]*?)</script>')
    if (-not $m.Success) {
      $stderr = if (Test-Path -LiteralPath $errFile) { Get-Content -LiteralPath $errFile -Raw } else { '' }
      throw "No '$name' output (browser exit code $($proc.ExitCode)).`n$stderr"
    }
    $target = Join-Path $assets "$name.svg"
    [System.IO.File]::WriteAllText($target, $m.Groups[1].Value, $utf8NoBom)
    Write-Host ('  wrote assets\{0,-13} {1,8:N0} bytes' -f "$name.svg", (Get-Item -LiteralPath $target).Length)
  }
  Write-Host 'Done. Commit the assets folder to publish the new SVGs.'
}
finally {
  try { Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction Stop } catch { }
}
