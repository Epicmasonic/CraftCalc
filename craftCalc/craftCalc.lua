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
local tempFile = "craftCalc/temp.txt"

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
        --- @diagnostic disable-next-line: missing-parameter
        clearScreen()
        error("How did you pick an option that doesn't exist?")
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

    local pickedRecipe, pickedName = pickRecipe(1)

    if (not pickedRecipe) then
        mainMenu()
        return
    end

    showRecipe(pickedRecipe, pickedName)
    
    mainMenu()
end

function pickRecipe(page, looped)
    local options = data.pageTable(recipes, page)
    local recipeCount = data.tableLength(recipes)

    local finalPage = math.ceil((recipeCount) / 10)

    if (finalPage <= 0) then
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("You haven't added any recipes yet!", textSpeed, false)
        ui.waitUntilKey()
        return
    end

    if (looped) then
        --- @diagnostic disable-next-line: missing-parameter
        clearScreen()
        print("What recipe do you want to view?")
        term.setTextColor(colors.lightGray)
        print("(Page "..page.." out of "..finalPage..")")
        term.setTextColor(colors.white)
    else
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("What recipe do you want to view?", textSpeed, true)
        term.setTextColor(colors.lightGray)
        ui.basic.slowPrint("(Page "..page.." out of "..finalPage..")", textSpeed, true)
        term.setTextColor(colors.white)
    end

    local picked = ui.pagedListInput(options, textSpeed)

    if (picked <= 10) then
        return recipes[options[picked]], options[picked]
    elseif (picked == 11) then
        if (page == finalPage) then
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

function showRecipe(recipe, name)
    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Recipe: "..name.."\n\nInputs\n", textSpeed, true)

    if (#recipe["Inputs"] > 1) then
        for i = 1, #recipe["Inputs"] - 1, 1 do
            item = recipe["Inputs"][i]
            ui.basic.slowPrint("- "..item["Item"].." x"..item["Count"], textSpeed, true)
        end
    end
    finalItem = recipe["Inputs"][#recipe["Inputs"]]
    ui.basic.slowWrite("- "..finalItem["Item"].." x"..finalItem["Count"].."\n", textSpeed, false)
    
    ui.waitUntilKey()

    if (recipe["Catalysts"]) then
        ---@diagnostic disable-next-line: missing-parameter
        clearScreen()
        print("Recipe: "..name.."\n")
        ui.basic.slowPrint("Catalysts\n", textSpeed, true)

        if (#recipe["Catalysts"] > 1) then
            for i = 1, #recipe["Catalysts"] - 1, 1 do
                item = recipe["Catalysts"][i]
                ui.basic.slowPrint("- "..item["Item"].." x"..item["Count"], textSpeed, true)
            end
        end
        finalItem = recipe["Catalysts"][#recipe["Catalysts"]]
        ui.basic.slowWrite("- "..finalItem["Item"].." x"..finalItem["Count"].."\n", textSpeed, false)

        ui.waitUntilKey()
    end

    ---@diagnostic disable-next-line: missing-parameter
    clearScreen()
    print("Recipe: "..name.."\n")
    ui.basic.slowPrint("Outputs\n", textSpeed, true)

    if (#recipe["Outputs"] > 1) then
        for i = 1, #recipe["Outputs"] - 1, 1 do
            item = recipe["Outputs"][i]
            ui.basic.slowPrint("- "..item["Item"].." x"..item["Count"], textSpeed, true)
        end
    end
    finalItem = recipe["Outputs"][#recipe["Outputs"]]
    ui.basic.slowWrite("- "..finalItem["Item"].." x"..finalItem["Count"].."\n", textSpeed, false)
    
    ui.waitUntilKey()
end

---Lets the user add new recipes
function addMode()
    --if fs.exists(tempFile) then -- I want to add something to resume adding a recipe if the program crashes but the `goto`s kept getting mad at me :(
    --    tempRecipe = data.loadData(tempFile)
    --end
    --if (tempRecipe["Step"] == "Inputs") then
    --    goto setInputs
    --elseif (tempRecipe["Step"] == "Catalysts") then
    --    goto setCatalysts
    --elseif (tempRecipe["Step"] == "Outputs") then
    --    goto setOutputs
    --elseif (tempRecipe["Step"] == "Saving") then
    --    goto saving
    --end

    local name = nameRecipe()
    if (not name) then
        mainMenu()
        return
    end

    local tempRecipe = {Mode = "Add", Step = "Inputs", [name] = {}}
    data.saveData(tempRecipe, tempFile)

    --::setInputs::
    tempRecipe[name]["Inputs"] = createSection("input")
    tempRecipe["Step"] = "Catalysts"
    data.saveData(tempRecipe, tempFile)

    --::setCatalysts::
    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Does this recipe use catalysts?\n(Items that are needed but aren't consumed)", textSpeed, true)
    if (ui.binaryInput()) then
        tempRecipe[name]["Catalysts"] = createSection("catalyst")
        tempRecipe["Step"] = "Outputs"
        data.saveData(tempRecipe, tempFile)
    end

    --::setOutputs::
    tempRecipe[name]["Outputs"] = createSection("output")
    tempRecipe["Step"] = "Saving"
    data.saveData(tempRecipe, tempFile)

    --::saving::
    fs.delete(tempFile)
    recipes[name] = tempRecipe[name]
    data.saveData(recipes, saveFile)

    mainMenu()
end

function nameRecipe()
    ::start::

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("What do you want to name the recipe?", textSpeed, true)
    local newName = ui.textInput()
    
    for oldName, _ in pairs(recipes) do
        if (newName:lower() == oldName:lower()) then
            ui.basic.clearScreen(1 / textSpeed)
            ui.basic.slowPrint("A recipe with that name already exists!\nWhat do you want to do about it?", textSpeed, false)
            local option = ui.listInput({"Edit it", "Try a different name", "Go back"}, textSpeed)

            if (option == 1) then
                break
            elseif (option == 2) then
                goto start
            elseif (option == 3) then
                return nil
            else
                --- @diagnostic disable-next-line: missing-parameter
                clearScreen()
                error("How did you pick an option that doesn't exist?")
            end
        end
    end

    return newName
end

function createSection(type)
    local section = {}
    local menu = {}
    
    ::start::

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Pick a slot to add a "..type.." to.", textSpeed, true)
    term.setTextColor(colors.lightGray)
    ui.basic.slowPrint("(There are only 9 slots)", textSpeed, true)
    term.setTextColor(colors.white)

    local first = true
    for i = 1, 9 do
        if (section[i]) then
            menu[i] = section[i]["Item"].." x"..section[i]["Count"]
        else
            if (first) then
                menu[i] = "Add new"
                first = false
            else
                menu[i] = ""
            end
        end
    end
    menu[10] = "Finish Editing"
    
    local slot = ui.listInput(menu, textSpeed)
    if (slot == 10) then
        if (#section == 0 and type ~= "catalyst") then
            ui.basic.clearScreen(1 / textSpeed)
            ui.basic.slowPrint("You need to add at least one "..type.."!", textSpeed, false)
            ui.waitUntilKey()
            goto start
        end
        return section
    else
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("What item do you want to put in slot "..slot.."?", textSpeed, true)
        local item = ui.textInput()

        ui.basic.clearScreen(1 / textSpeed)
        if (type == "output") then
            ui.basic.slowPrint("How many copys of \""..item.."\" do you get?", textSpeed, true)
        else
            ui.basic.slowPrint("How many copys of \""..item.."\" do you need?", textSpeed, true)
        end
        local count = ui.numberInput()

        section[slot] = {Item = item, Count = count}
        goto start
    end
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
