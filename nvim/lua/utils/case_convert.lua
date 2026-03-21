local M = {}

-- Split word into parts based on camelCase, PascalCase, snake_case, kebab-case, etc
local function split_words(str)
  local words = {}

  -- Replace separators with space
  str = str:gsub("[-_]", " ")

  -- Add space before capital letters (for camel/Pascal)
  str = str:gsub("(%l)(%u)", "%1 %2")
  str = str:gsub("(%u)(%u%l)", "%1 %2")

  for word in str:gmatch("%S+") do
    table.insert(words, word:lower())
  end

  return words
end

local function capitalize(word)
  return word:sub(1,1):upper() .. word:sub(2)
end

function M.to_snake_case(str)
  return table.concat(split_words(str), "_")
end

function M.to_kebab_case(str)
  return table.concat(split_words(str), "-")
end

function M.to_camel_case(str)
  local words = split_words(str)
  for i = 2, #words do
    words[i] = capitalize(words[i])
  end
  return table.concat(words, "")
end

function M.to_pascal_case(str)
  local words = split_words(str)
  for i = 1, #words do
    words[i] = capitalize(words[i])
  end
  return table.concat(words, "")
end

function M.to_upper_case(str)
  return str:upper()
end

function M.to_lower_case(str)
  return str:lower()
end

return M
