#!/usr/bin/env bash
input=$(cat)

width="${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}"

# LEFT: project and branch
proj=$(echo "$input" | jq -r '.workspace.repo.name // empty')
if [ -z "$proj" ]; then
  proj=$(echo "$input" | jq -r '.workspace.current_dir' | xargs basename 2>/dev/null)
fi

branch=$(git -C "$(echo "$input" | jq -r '.workspace.current_dir')" \
  --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

left=""
left_len=0

if [ -n "$proj" ]; then
  left="🗂 ${proj}"
  # 🗂 is 2 terminal cols wide, + 1 space + proj chars
  left_len=$(( 3 + ${#proj} ))
fi

if [ -n "$branch" ]; then
  part="⎇ ${branch}"
  # ⎇ is 1 col wide + 1 space + branch chars
  part_len=$(( 2 + ${#branch} ))
  if [ -n "$left" ]; then
    left="${left}   ${part}"
    left_len=$(( left_len + 3 + part_len ))
  else
    left="$part"
    left_len=$part_len
  fi
fi

# RIGHT: usage stats, no emojis, plain text
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

right_parts=()
[ -n "$ctx" ]  && right_parts+=("ctx $(printf '%.0f' "$ctx")%")
[ -n "$five" ] && right_parts+=("5h $(printf '%.0f' "$five")%")
[ -n "$week" ] && right_parts+=("7d $(printf '%.0f' "$week")%")

right=""
for part in "${right_parts[@]}"; do
  [ -z "$right" ] && right="$part" || right="${right}  ·  ${part}"
done

right_len=${#right}

# Padding to right-align stats
pad=$(( width - left_len - right_len ))
[ "$pad" -lt 1 ] && pad=1
padding=$(printf '%*s' "$pad" '')

printf "%s%s%s\n" "$left" "$padding" "$right"
