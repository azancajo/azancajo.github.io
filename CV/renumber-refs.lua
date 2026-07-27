--[[
renumber-refs.lua – number bibliography entries 1..N in display order.

pandoc's citeproc assigns `citation-number` by ascending date, but the CV
lists publications newest first, so the printed numbers count down. This
filter rewrites the left-margin label of each entry to its position in the
list as displayed. Runs after multibib.lua has filled the #refs-* divs.
]]

local function renumber (div)
  if not div.classes:includes('csl-bib-body') then
    return nil
  end
  local n = 0
  return pandoc.walk_block(div, {
    Span = function (span)
      if span.classes:includes('csl-left-margin') then
        n = n + 1
        return pandoc.Span({pandoc.Str(n .. '.'), pandoc.Space()}, span.attr)
      end
    end
  })
end

return {{Div = renumber}}
