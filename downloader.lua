local files = {
  "craftCalc.lua",
  "functions/uiBasic",
  "functions/ui",
  "functions/dataHandling",
  "functions/overcomplated"
}

for _, file in files do
  shell.run("wget https://raw.githubusercontent.com/Epicmasonic/CraftCalc/main/craftCalc/"..file.." craftCalc/"..file)
end
