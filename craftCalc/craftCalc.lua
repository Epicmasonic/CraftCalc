--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

local data = require("functions.dataHandling")
local ui = require("functions.ui")

---------------- Config ----------------

---The saved recipes
local recipes = {}

---How many characters will be drawn in one second by slowPrint and slowWrite
local textSpeed = 30

---The path of the file recipes should be kept in
local saveFile = "craftCalc/recipes.txt"

---------------- Functions ----------------

---Warns the user of unfinished code
function unfinished()
    ui.basic.clearScreen(1 / textSpeed)
    
    ui.basic.slowPrint("This part isn't done being coded.\nPlease try again later.", textSpeed)
    ui.waitUntilKey()
end

---Lets the user pick from the avalable modes
function mainMenu()
    ui.basic.clearScreen(1 / textSpeed)

    ui.basic.slowPrint("What do you want to do?", textSpeed, true)
    local mode = listInput({"View added recipes", "Add new recipe", "Calculate ingredients", "", "", "", "", "", "", "Exit Program"}, textSpeed)

    if (mode == 10) then
        exitProgram()
		return
    elseif (mode == 1) then
        viewMode()
        return
    elseif (mode == 2) then
        addMode()
        return
    elseif (mode == 3) then
        craftMode()
        return
    else
        clearScreen()
        error("How did you do that?")
    end
end

---Exits the program with a small message
function exitProgram()
    ui.basic.clearScreen(1 / textSpeed)

    ui.basic.slowPrint("Have a good day!", textSpeed)
    ui.waitUntilKey()
end

---Lets the user view their added recipes
function viewMode()
    ui.basic.clearScreen(1 / textSpeed)

    local pickedRecipe = pickRecipe(1)

    if (not pickedRecipe) then
        mainMenu()
        return
    end

    unfinished()
    mainMenu()
end

function pickRecipe(page, looped)
    local options, lastPage = data.pageTable(recipes, page)

    if (#options == 0) then
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("You haven't added any recipes yet!", textSpeed, false)
        ui.waitUntilKey()
        return
    end

    local finalPage = math.ceil((#recipes + 1) * 10) / 10

    if (looped) then
        ui.basic.clearScreen(0)
        print("What recipe do you want to view?")
    else
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("What recipe do you want to view?", textSpeed, true)
    end

    sleep(1 / textSpeed)
    term.setTextColor(colors.lightGray)
    print("Page "..page.."/"..finalPage)
    term.setTextColor(colors.white)

    local picked = ui.pagedListInput(options, textSpeed)

    if (picked <= 10) then
        return recipes[options[picked]]
    elseif (picked == 11) then
        if (lastPage) then
            return pickRecipe(1, true)
        else
            return pickRecipe(page + 1, true)
        end
    elseif (picked == 12) then
        if (page == 1) then
            return pickRecipe(finalPage, true)
        else
            return pickRecipe(page - 1, true)
        end
    end
end

---Lets the user add new recipes
function addMode()
    ui.basic.clearScreen(1 / textSpeed)

    -- Code goes here

    unfinished()
    mainMenu()
end

---The main mode, lets the user calculate the required items to craft an item
function craftMode()
    ui.basic.clearScreen(1 / textSpeed)

    -- Code goes here

    unfinished()
    mainMenu()
end

---------------- The stuff that actually gets run ----------------

if fs.exists("craftCalc/recipes.txt") then
    recipes = data.loadData(saveFile)
else
    data.saveData(recipes, saveFile)
end

mainMenu()
ui.basic.clearScreen(1 / textSpeed)
