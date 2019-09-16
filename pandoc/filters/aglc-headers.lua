local text = require('text')

local letters = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
}

function to_alpha(num)
  local result = ''
  while num > 0 do
    num = num - 1
    local remainder = math.fmod(num, 26)
    result = letters[remainder + 1] .. result
    num = math.floor((num - remainder) / 26)
  end
  return result
end

function to_ALPHA(num)
  return text.upper(to_alpha(num))
end

function to_emph(el)
  return pandoc.walk_block(el, {
    Str = function(el)
      return pandoc.Emph(pandoc.Str(el.text))
    end
  })
end

function to_upper(el)
  return pandoc.walk_block(el, {
    Str = function(el)
      return pandoc.Str(text.upper(el.text))
    end
  })
end

function to_smallcaps(el)
  return pandoc.walk_block(el, {
    Str = function(el)
      return pandoc.SmallCaps(el.text)
    end
  })
end

function to_roman(num)
  local III = pandoc.utils.to_roman_numeral(num)
  return text.lower(III)
end


-- print(to_alpha(1))
-- print(to_alpha(2))
-- print(to_alpha(26))
-- print(to_alpha(27))
-- print(to_alpha(28))

local levels = { 0, 0, 0, 0, 0 }

-- local strict = false
-- -- maybe add smallcaps one day
-- -- determine if we're using strict mode
-- function Meta(m)
--   if (m.aglc-headers-strict) then
--     strict = true
--   end
-- end

function big_space() 
  -- latex fonts don't do character fallback well.
  if FORMAT == "latex" then
    return pandoc.RawInline("latex", "\\enspace")
  else
    return pandoc.Str(" ") -- en space
  end
end

function Header(el)
  if el.level == 1 then
    levels[1] = levels[1] + 1
    levels[2] = 0
    levels[3] = 0
    levels[4] = 0
    levels[5] = 0
    el = to_smallcaps(el)
    if el.identifier ~= 'refs' then
      table.insert(el.content, 1, pandoc.Str(pandoc.utils.to_roman_numeral(levels[1])))
    end
    table.insert(el.content, 2, big_space())
    return el
  end
  if el.level == 2 then
    levels[2] = levels[2] + 1
    levels[3] = 0
    levels[4] = 0
    levels[5] = 0
    el = to_emph(el)
    table.insert(el.content, 1, pandoc.Str(to_ALPHA(levels[2])))
    table.insert(el.content, 2, big_space())
    return el
  end
  if el.level == 3 then
    levels[3] = levels[3] + 1
    levels[4] = 0
    levels[5] = 0
    el = to_emph(el)
    table.insert(el.content, 1, pandoc.Str(levels[3]))
    table.insert(el.content, 2, big_space())
    return el
  end
  if el.level == 4 then
    levels[4] = levels[4] + 1
    levels[5] = 0
    table.insert(el.content, 1, pandoc.Str('('..to_alpha(levels[4])..')'))
    table.insert(el.content, 2, big_space())
    return to_emph(el)
  end
  if el.level == 5 then
    levels[5] = levels[5] + 1
    table.insert(el.content, 1, pandoc.Str('('..to_roman(levels[5])..')'))
    table.insert(el.content, 2, big_space())
    return to_emph(el)
  end
end
