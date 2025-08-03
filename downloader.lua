local files = {
  "craftCalc.lua",
  "functions/overcomplicated.lua",
  "functions/dataHandling.lua",
  "functions/uiBasic.lua",
  "functions/ui.lua"
}

for _, file in ipairs(files) do
  fs.delete("craftCalc/"..file)
  shell.run("wget https://raw.githubusercontent.com/Epicmasonic/craftCalc/main/craftCalc/"..file.." craftCalc/"..file)
end
