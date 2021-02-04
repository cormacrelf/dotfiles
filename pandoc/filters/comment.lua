-- suppress the question generated bibliography (div class=refs)
--
function Div(el)
  if (el.attr.identifier == "refs") then
    return {}
  end
  -- if (el.classes[1] == "not-counted") then
  --   return {}
  -- end
  if (el.classes[1] == "comment") then
    return {}
  end
  return el
end

