# Setup guide

This folder is a complete GitHub **profile README** for [github.com/Muhammadgi](https://github.com/Muhammadgi).

GitHub shows the `README.md` from the special repository named like your username at the top of your profile. You already have that repository, so this update replaces its README:

```text
github.com/Muhammadgi/Muhammadgi   ← your profile repository (already exists)
└── README.md                      ← shown on github.com/Muhammadgi
```

The whole update takes about 10 minutes. Your previous README stays in the repository's commit history if you ever want it back.

---

## 1. Review the content

Your GitHub username, LinkedIn, X, Instagram and email are already filled in. The stack, certifications and goals come from your previous README, and the project cards point to your real repositories.

Things to check before publishing:

- **Portfolio**: `codebyharris.com` no longer resolves, so its badge is commented out at the top of `README.md`. Put your live portfolio URL there and remove the `<!--` and `-->` around it.
- **Tech stack**: delete anything you no longer use, or add icons. The `skillicons.dev` IDs are listed at <https://skillicons.dev>.
- **Featured projects**: swap any card for another repository you'd rather show.

## 2. Personalise the animated SVGs (optional)

The banner, terminal and footer are generated from **`tools/config.js`**. It holds your name, prompt (`haris@infra`), typed roles, the neofetch lines and the tmux bar.

1. Edit `tools/config.js`.
2. Preview it by opening `tools/build.html` in Chrome or Edge. It shows the SVGs on dark and light backgrounds.
3. Rebuild the files in `assets/`:

   ```powershell
   powershell -ExecutionPolicy Bypass -File tools\build.ps1
   ```

The build uses headless Chrome or Edge that is already on your PC. It needs no Node.js, Python or internet connection. If your browser lives somewhere unusual, add `-Browser "C:\path\to\chrome.exe"`.

> Don't hand-edit the SVGs: every typed character has its own timing, so it's easier to change the config and rebuild.

## 3. Upload the files

### Option A: in the browser (no Git needed)

1. Open <https://github.com/Muhammadgi/Muhammadgi>.
2. Click **Add file** → **Upload files**.
3. Drag in `README.md`, `SETUP.md`, and the `assets` and `tools` folders. The new `README.md` replaces the old one. Click **Commit changes**.
4. Add the workflow by hand, because browser uploads often skip folders that start with a dot:
   - **Add file** → **Create new file**.
   - Name it `.github/workflows/snake.yml`. Typing the `/` creates the folders.
   - Paste the contents of the local `.github/workflows/snake.yml` → **Commit changes**.

### Option B: with Git

Git isn't installed on this PC yet. Install it with `winget install --id Git.Git -e`, then reopen the terminal and run:

```powershell
git clone https://github.com/Muhammadgi/Muhammadgi.git
cd Muhammadgi
# copy everything from this folder (including the hidden .github folder) into here, then:
git add .
git commit -m "Animated terminal-themed profile README"
git push
```

## 4. Switch on the contribution snake

`.github/workflows/snake.yml` turns your contribution graph into an animated snake. It publishes the SVGs to a branch called `output`.

1. It runs automatically when the workflow file reaches `main`, then once a day.
2. To run it right away, open **Actions** → **Generate snake** → **Run workflow**.
3. After about a minute an `output` branch appears and the snake shows up on your profile.

If the run fails with *permission denied* or *403*, go to **Settings** → **Actions** → **General** → **Workflow permissions** and choose **Read and write permissions**. Save, then re-run the workflow.

## 5. Polish the rest of your profile

- **Settings → Public profile** (<https://github.com/settings/profile>): check your bio, location, website and social links.
- **Pinned repositories**: on your profile, click **Customize your pins** and choose your best repos, such as `aws-vpc-terraform`, `terraform-aws-ec2` and `VPS-Daily-Health-Report`.
- **Status**: click your avatar → **Set status** (for example 🐧 *Automating all the things*).

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Snake image is broken | The workflow hasn't run yet. See step 4. |
| Stats card shows an error | The free public host is rate-limited at times. Wait and refresh, or self-host [GitHub Stats Extended](https://github.com/stats-organization/github-stats-extended). |
| An updated SVG doesn't show | GitHub caches images. Hard-refresh with `Ctrl+F5`. For third-party widgets, add `&v=2` to the URL. |
| The SVGs don't move | Your OS has *reduce motion* turned on. The SVGs then show the finished frame on purpose. |
| `build.ps1` is blocked | Run it with `-ExecutionPolicy Bypass` as shown in step 2. |

## What's in this folder

```text
README.md                    the profile page
SETUP.md                     this guide (GitHub only renders README.md on your profile)
assets/banner.svg            animated header: name, typed roles, rack → cloud → pods
assets/terminal.svg          animated neofetch card with a pixel-art Tux
assets/footer.svg            "exit / logout" goodbye with a tmux status bar
.github/workflows/snake.yml  daily contribution-snake generator
tools/config.js              ✏️ the text used in the three SVGs
tools/build.ps1              rebuilds assets/*.svg from the config
tools/build.html             live preview + build page
tools/generate.js            the SVG generator (CSS keyframes + SMIL, no scripts)
tools/fonts.js, OFL.txt      embedded JetBrains Mono subset and its licence
```

## Credits

- [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono): SIL Open Font License 1.1, embedded as a subset.
- [skillicons.dev](https://skillicons.dev) and [shields.io](https://shields.io): tech icons and badges.
- [GitHub Stats Extended](https://github.com/stats-organization/github-stats-extended) and [GitHub Readme Streak Stats](https://github.com/DenverCoder1/github-readme-streak-stats): stats cards.
- [Platane/snk](https://github.com/Platane/snk): contribution snake.
- [hits.sh](https://hits.sh): profile views badge.
