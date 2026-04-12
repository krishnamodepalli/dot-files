#!/usr/bin/env python3
"""
gh_guard.py — PreToolUse hook for Bash tool.

Blocks destructive or irreversible `gh` and `git` operations that Claude
should never perform autonomously. These require explicit manual confirmation
from the user.
"""

import json
import re
import sys

data = json.load(sys.stdin)
cmd = data.get("command", "")

# ── gh guards ────────────────────────────────────────────────────────────────

if re.search(r"\bgh\b", cmd):
    GH_BLOCKED = [
        # PR lifecycle changes
        (r"\bgh\s+pr\s+(merge|close|reopen|delete)\b", "merging/closing/deleting PRs"),
        # Issue lifecycle changes
        (r"\bgh\s+issue\s+(close|reopen|delete|lock|unlock)\b", "closing/deleting/locking issues"),
        # Release management
        (r"\bgh\s+release\s+(create|delete|edit)\b", "creating/editing/deleting releases"),
        # Repo-level destructive ops
        (r"\bgh\s+repo\s+(delete|rename|transfer|archive)\b", "deleting/renaming/transferring repos"),
        # Raw DELETE API calls
        (r"\bgh\s+api\b.*\bDELETE\b", "DELETE API calls via gh api"),
        # Auto-confirm / admin flags
        (r"\bgh\b.*--yes\b", "gh commands with --yes (auto-confirms destructive prompts)"),
        (r"\bgh\b.*--admin\b", "gh commands with --admin flag"),
    ]

    for pattern, description in GH_BLOCKED:
        if re.search(pattern, cmd, re.IGNORECASE):
            print(
                f"[gh_guard] Blocked: {description} requires manual confirmation.\n"
                f"Command: {cmd.strip()}\n"
                f"Please do this yourself or explicitly tell me you want me to run it."
            )
            sys.exit(1)

# ── git guards ───────────────────────────────────────────────────────────────

if re.search(r"\bgit\b", cmd):
    GIT_BLOCKED = [
        # Force push — any remote, any branch
        (r"\bgit\s+push\b.*--force\b", "force push (rewrites remote history)"),
        (r"\bgit\s+push\b.*-f\b", "force push (rewrites remote history)"),
        # Hard reset — discards uncommitted work
        (r"\bgit\s+reset\b.*--hard\b", "git reset --hard (discards uncommitted changes)"),
        # Clean — deletes untracked files
        (r"\bgit\s+clean\b.*-f\b", "git clean -f (permanently deletes untracked files)"),
        # Force-delete branches (-D only; lowercase -d is safe — only deletes merged branches)
        (r"\bgit\s+branch\b.*-D\b", "force-deleting a branch"),
        (r"\bgit\s+branch\b.*--delete\s+--force\b", "force-deleting a branch"),
        # Rebase with force/autosquash on published branches
        (r"\bgit\s+push\b.*--force-with-lease\b", "force-push with lease (still rewrites remote history)"),
    ]

    for pattern, description in GIT_BLOCKED:
        if re.search(pattern, cmd):
            print(
                f"[git_guard] Blocked: {description} requires manual confirmation.\n"
                f"Command: {cmd.strip()}\n"
                f"Please do this yourself or explicitly tell me you want me to run it."
            )
            sys.exit(1)

sys.exit(0)
