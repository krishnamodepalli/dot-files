# Global Claude Configuration

## Available CLI Tools

Prefer these tools when processing structured data or searching — they are faster and produce cleaner output than shell builtins.

### Data processing
| Tool | Use for |
|------|---------|
| `jq` | Parse, filter, and transform JSON — always use with `gh --json` output |
| `yq` | Parse, filter, and transform YAML |

### Search & navigation
| Tool | Command | Use for |
|------|---------|---------|
| `rg` | ripgrep | Fast content search (prefer the Grep tool when possible) |
| `fd` | fdfind (aliased as `fd`) | Fast file search by name/pattern |

### HTTP
| Tool | Use for |
|------|---------|
| `http` | httpie — human-friendly HTTP requests (`http GET url`, `http POST url key=val`) |
| `xh` | Faster httpie-compatible alternative (`xh GET url`) — installed at `~/apps/bin` |

### Git
| Tool | Use for |
|------|---------|
| `git` | Version control — delta is configured as the default pager for beautiful diffs |
| `gh` | GitHub CLI — PRs, issues, releases, repo management |
| `lazygit` | Terminal UI for git — installed at `~/apps/bin/lazygit` (interactive — not useful in non-interactive contexts) |

### File viewing
| Tool | Use for |
|------|---------|
| `bat` | Syntax-highlighted file viewer (aliased as `bat`, binary is `batcat`) |
| `eza` | Modern `ls` with icons and git status (aliased as `ls`) |

### Python
| Tool | Use for |
|------|---------|
| `uv` | Fast Python package/venv manager — prefer over `pip` for new installs |
| `python3` | Python interpreter (aliased as `py`) |
| `direnv` | Auto-loads `.envrc` per directory — active in zsh |

### gh + jq pattern
`gh` supports `--json <fields>` on most commands. Always combine with `jq` for clean output:
```bash
gh pr view 42 --json title,body,labels,state | jq '{title, state, labels: [.labels[].name]}'
gh pr list --json number,title,headRefName | jq '.[] | "\(.number) \(.title)"'
gh issue list --json number,title,labels | jq '.[] | select(.labels[].name == "bug")'
```
