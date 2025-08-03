local files = {
  "craftCalc.lua",
  "functions/overcomplated.lua",
  "functions/dataHandling.lua",
  "functions/uiBasic.lua",
  "functions/ui.lua"
}

for _, file in ipairs(files) do
  shell.run("wget https://raw.githubusercontent.com/Epicmasonic/CraftCalc/main/craftCalc/"..file.." craftCalc/"..file)
end
