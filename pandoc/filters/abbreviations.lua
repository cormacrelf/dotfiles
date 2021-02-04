local vars = {}

function get_vars (doc)
  for k, v in pairs(doc.meta) do
    if type(v) == "table" then
      vars["$" .. k .. "$"] = {table.unpack(v)}
    end
  end
end

function replace (el)
  if vars[el.text] then
    return pandoc.Span(vars[el.text])
  else
    return el
  end
end

return {{Pandoc = get_vars}, {Str = replace}}
