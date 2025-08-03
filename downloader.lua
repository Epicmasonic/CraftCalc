local files = {
  "craftCalc.lua",
  "functions/overcomplated",
  "functions/dataHandling",
  "functions/uiBasic",
  "functions/ui"
}

for _, file in ipairs(files) do
  shell.run("wget https://raw.githubusercontent.com/Epicmasonic/CraftCalc/main/craftCalc/"..file.." craftCalc/"..file)
end
