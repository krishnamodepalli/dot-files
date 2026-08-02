#!/usr/bin/env bash
input=$(cat)

if [ -n "$NO_COLOR" ]; then
  reset=""; dim=""; c_red=""; c_yellow=""; c_green=""; c_cyan=""
else
  reset=$'\033[0m'
  dim=$'\033[2m'
  c_red=$'\033[31m'
  c_yellow=$'\033[33m'
  c_green=$'\033[32m'
  c_cyan=$'\033[36m'
fi

cwd=$(jq -r '.workspace.current_dir' <<< "$input")

proj=$(jq -r '.workspace.repo.name // empty' <<< "$input")
[ -z "$proj" ] && proj=$(basename "$cwd" 2>/dev/null)

branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

model=$(jq -r '.model.display_name // empty' <<< "$input")

ctx=$(jq -r '.context_window.used_percentage // empty' <<< "$input")
five=$(jq -r '.rate_limits.five_hour.used_percentage // empty' <<< "$input")
week=$(jq -r '.rate_limits.seven_day.used_percentage // empty' <<< "$input")

# label a percentage, colored by severity (green < 50, yellow < 80, red >= 80)
fmt_pct() {
  local label="$1" pct="$2"
  [ -z "$pct" ] && return
  local rounded color
  rounded=$(printf '%.0f' "$pct")
  color=$(awk -v p="$pct" -v r="$c_red" -v y="$c_yellow" -v g="$c_green" \
    'BEGIN { print (p >= 80) ? r : (p >= 50) ? y : g }')
  printf '%s%s %s%s%%%s' "$dim" "$label" "$reset$color" "$rounded" "$reset"
}

segments=()
[ -n "$proj" ]   && segments+=("🗂 ${proj}")
[ -n "$branch" ] && segments+=("⎇ ${branch}")
[ -n "$model" ]  && segments+=("${c_cyan}${model}${reset}")

pct_ctx=$(fmt_pct "ctx" "$ctx")
pct_5h=$(fmt_pct "5h" "$five")
pct_7d=$(fmt_pct "7d" "$week")
[ -n "$pct_ctx" ] && segments+=("$pct_ctx")
[ -n "$pct_5h" ]  && segments+=("$pct_5h")
[ -n "$pct_7d" ]  && segments+=("$pct_7d")

sep="  ${dim}·${reset}  "
line=""
for seg in "${segments[@]}"; do
  [ -z "$line" ] && line="$seg" || line="${line}${sep}${seg}"
done

printf '%s\n' "$line"
