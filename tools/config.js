/*
 * ✏️  PROFILE CONFIG: edit this file, then rebuild the SVGs:
 *
 *     powershell -ExecutionPolicy Bypass -File tools\build.ps1
 *
 * Everything below ends up inside assets/banner.svg, assets/terminal.svg and
 * assets/footer.svg. Plain ASCII is safest; the separators used below (· ♥ →)
 * are also included in the embedded font.
 */
window.PROFILE = {
  // Big name in the banner
  name: 'Muhammad Haris',

  // Shell prompt shown everywhere:  user@host:~$
  prompt: { user: 'haris', host: 'infra' },

  banner: {
    command: 'whoami',
    // Typed one after another, on a loop (keep each under ~24 characters)
    roles: ['DevOps & Cloud Engineer', 'Linux Administrator', 'AI/ML Infrastructure', 'Multi-Cloud Architect'],
    tagline: 'Automation-first cloud platforms for AI-driven systems.',
    status: 'all systems operational'
  },

  terminal: {
    command: 'neofetch',
    // [label, value] pairs shown next to the penguin (keep values under ~55 chars)
    fields: [
      ['OS', 'Ubuntu · RHEL · CentOS · Debian'],
      ['Role', 'DevOps & Cloud Engineer · Linux Administrator'],
      ['Cloud', 'AWS · Azure · GCP · Hetzner'],
      ['IaC', 'Terraform · Ansible · CloudFormation · Pulumi'],
      ['Containers', 'Docker · Kubernetes (EKS/AKS/GKE) · Helm · Istio'],
      ['CI/CD', 'GitHub Actions · GitLab CI · Jenkins · n8n'],
      ['AI/ML', 'LLM & RAG platforms · MCP servers · Bedrock'],
      ['Monitoring', 'Prometheus · Grafana · ELK · CloudWatch'],
      ['Security', 'IAM · RBAC · Vault · fail2ban · iptables'],
      ['Languages', 'Python · Go · Bash · Node.js'],
      ['Motto', 'If you do it twice, automate it.']
    ],
    // A second command typed after neofetch
    extra: {
      command: 'uptime',
      output: ' 13:37:00 up 365 days,  1 user,  load average: 0.42, 0.42, 0.42'
    }
  },

  footer: {
    command: 'exit',
    lines: ['logout', 'Connection to github.com closed. Thanks for visiting!'],
    // tmux-style status bar
    session: 'infra',
    windows: ['bash', 'docker', 'kubectl', 'terraform', 'ansible'],
    right: ['up 24/7', '♥ thanks for visiting']
  }
};
