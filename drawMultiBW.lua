-- File: /SCRIPTS/TOOLS/drawMultiBW.lua

local images = dofile("/SCRIPTS/TOOLS/multi_bmp.lua")
local index = 1
local total = #images

local function drawImage(img)
  for y=0,63 do
    local row = img[y+1]
    for xByte=0,15 do
      local byte = row[xByte+1]
      for b=0,7 do
        if bit32.extract(byte, 7 - b) == 1 then
          lcd.drawPoint(xByte*8 + b, y)
        end
      end
    end
  end
end

local function run(event)
  if event == EVT_PLUS_BREAK or event == EVT_ROT_RIGHT then
    index = index + 1
    if index > total then index = 1 end
  elseif event == EVT_MINUS_BREAK or event == EVT_ROT_LEFT then
    index = index - 1
    if index < 1 then index = total end
  end

  lcd.clear()
  drawImage(images[index])

  return 0
end

return { run=run }