--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

-- Uncomment this line when testing with mindbg
-- package.path = package.path .. ";/craftCalc/?.lua;/craftCalc/?/init.lua"

local data = require("functions.dataHandling")
local ui = require("functions.ui")

---------------- Config ----------------

---The saved recipes
local recipes = {}

---How many characters will be drawn in one second by slowPrint and slowWrite
local textSpeed = 30

---The path of the file recipes should be kept in
local saveFile = "craftCalc/recipes.txt"

---The path of the temporary file used when adding a new recipe -- I will probably murge viewMode and addMode which will make this unneeded
--local tempFile = "craftCalc/temp.txt"

---The path of the file the calculated results should be saved to
local resultsFile = "craftCalc/wishlist.txt"

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

    ui.basic.slowPrint("Are you sure you want to leave?", textSpeed, true)
    if (not(ui.binaryInput())) then
		mainMenu()
	end
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
    local primaryText = ""
    if (recipe["Primary"]) then
        primaryText = "Primary"
    else
        primaryText = "Secondary"
    end

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Recipe: "..name, textSpeed, true)
    ui.basic.slowPrint("Use: "..toItemName(recipe["Main Output"]), textSpeed, true)
    ui.basic.slowPrint("Importance: "..primaryText, textSpeed, true)
    ui.basic.slowPrint("\nInputs\n", textSpeed, true)

    if (#recipe["Inputs"] > 1) then
        for i = 1, #recipe["Inputs"] - 1, 1 do
            item = recipe["Inputs"][i]
            ui.basic.slowPrint("- "..toItemName(item["Item"]).." x"..item["Count"], textSpeed, true)
        end
    end
    finalItem = recipe["Inputs"][#recipe["Inputs"]]
    ui.basic.slowPrint("- "..toItemName(finalItem["Item"]).." x"..finalItem["Count"], textSpeed, false)
    
    ui.waitUntilKey()

    if (recipe["Catalysts"]) then
        ---@diagnostic disable-next-line: missing-parameter
        clearScreen()
        print("Recipe: "..name)
        print("Use: "..toItemName(recipe["Main Output"]))
        print("Importance: "..primaryText)
        ui.basic.slowPrint("\nCatalysts\n", textSpeed, true)

        if (#recipe["Catalysts"] > 1) then
            for i = 1, #recipe["Catalysts"] - 1, 1 do
                item = recipe["Catalysts"][i]
                ui.basic.slowPrint("- "..toItemName(item["Item"]).." x"..item["Count"], textSpeed, true)
            end
        end
        finalItem = recipe["Catalysts"][#recipe["Catalysts"]]
        ui.basic.slowPrint("- "..toItemName(finalItem["Item"]).." x"..finalItem["Count"], textSpeed, false)

        ui.waitUntilKey()
    end

    ---@diagnostic disable-next-line: missing-parameter
    clearScreen()
    print("Recipe: "..name)
    print("Use: "..toItemName(recipe["Main Output"]))
    print("Importance: "..primaryText)
    ui.basic.slowPrint("\nOutputs\n", textSpeed, true)

    if (#recipe["Outputs"] > 1) then
        for i = 1, #recipe["Outputs"] - 1, 1 do
            item = recipe["Outputs"][i]
            ui.basic.slowPrint("- "..toItemName(item["Item"]).." x"..item["Count"], textSpeed, true)
        end
    end
    finalItem = recipe["Outputs"][#recipe["Outputs"]]
    ui.basic.slowPrint("- "..toItemName(finalItem["Item"]).." x"..finalItem["Count"], textSpeed, false)
    
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
    --data.saveData(tempRecipe, tempFile)

    --::setInputs::
    tempRecipe[name]["Inputs"] = createSection("input")
    --tempRecipe["Step"] = "Catalysts"
    --data.saveData(tempRecipe, tempFile)

    --::setCatalysts::
    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Does this recipe use catalysts?\n(Items that are needed but aren't consumed)", textSpeed, true)
    if (ui.binaryInput()) then
        tempRecipe[name]["Catalysts"] = createSection("catalyst")
        --tempRecipe["Step"] = "Outputs"
        --data.saveData(tempRecipe, tempFile)
    end

    --::setOutputs::
    tempRecipe[name]["Outputs"] = createSection("output")
    --tempRecipe["Step"] = "Main Output"
    --data.saveData(tempRecipe, tempFile)

    --::setMain::
    if (#tempRecipe[name]["Outputs"] > 1) then
        tempRecipe[name]["Main Output"] = pickMainOuput(tempRecipe[name]["Outputs"])
    else
        tempRecipe[name]["Main Output"] = tempRecipe[name]["Outputs"][1]["Item"]
    end
    --tempRecipe["Step"] = "Primary"
    --data.saveData(tempRecipe, tempFile)

    --::setPrimary::
    local brandNew = true
    for _, recipe in pairs(recipes) do
        if (recipe["Main Output"] == tempRecipe[name]["Main Output"]) then
            brandNew = false
            break
        end
    end

    if (not brandNew) then
        tempRecipe[name]["Primary"] = setPrimary(tempRecipe[name]["Main Output"])
    else
        tempRecipe[name]["Primary"] = true
    end
    --tempRecipe["Step"] = "Saving"
    --data.saveData(tempRecipe, tempFile)

    --::saving::
    --fs.delete(tempFile)
    recipes[name] = tempRecipe[name]
    data.saveData(recipes, saveFile)

    mainMenu()
end

function nameRecipe()
    ::start::

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("What do you want to name the recipe?", textSpeed, true)
    local newName = toTitleCase(ui.textInput())
    
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
            menu[i] = toItemName(section[i]["Item"]).." x"..section[i]["Count"]
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
        local item = ui.itemInput()

        ui.basic.clearScreen(1 / textSpeed)
        if (type == "output") then
            ui.basic.slowPrint("How many copys of \""..toItemName(item).."\" do you get?", textSpeed, true)
        else
            ui.basic.slowPrint("How many copys of \""..toItemName(item).."\" do you need?", textSpeed, true)
        end
        local count = ui.numberInput()

        section[slot] = {Item = item, Count = count}
        goto start
    end
end

---A striped-down version of createSection for picking the main output
---@param outputs table The outputs to pick from
function pickMainOuput(outputs)
    local menu = {}

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Looks like there's multiple outputs.\nWhich one should this recipe be used for?", textSpeed, true)

    index = 1
    for _, output in pairs(outputs) do
        menu[index] = toItemName(output["Item"])
        index = index + 1
    end
    
    local slot = ui.listInput(menu, textSpeed)
    return outputs[slot]["Item"]
end

function setPrimary(mainOutput)
    local _, currentPrimary = findRecipe(mainOutput)

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Should this recipe be the primary way to make "..toItemName(mainOutput).."?", textSpeed, true)
    term.setTextColor(colors.lightGray)
    --ui.basic.slowPrint("(Secondary recipes will only be used if there are the matterials for them.)", textSpeed, true)
    ui.basic.slowPrint("(I haven't fully coded this system yet. Only primary recipes get used for now.)", textSpeed, true)
    ui.basic.slowPrint("\nThe current primary recipe is \""..currentPrimary.."\".", textSpeed, true)
    term.setTextColor(colors.white)

    local answer = ui.binaryInput()

    if (answer) then
        recipes[currentPrimary]["Primary"] = false
    end

    return answer
end

---The main mode, lets the user calculate the required items to craft an item
function craftMode()
    ui.basic.clearScreen(1 / textSpeed)

    local wishlist = {}

    local item = pickItem(1)
    if (not item) then
        mainMenu()
        return
    end
    ui.basic.clearScreen(1 / textSpeed)
    slowPrint("How many do you want to craft?", textSpeed, true)
    amount = ui.numberInput()
    ui.basic.clearScreen(1 / textSpeed)

    wishlist[item] = amount

    craftCalc(wishlist)

    showWishlist(wishlist, item, amount)

    mainMenu()
end

function pickItem(page, looped)
    local items = {}
    for _, recipe in pairs(recipes) do
        local contains = false
        for _, item in pairs(items) do
            if (item == recipe["Main Output"]) then
                contains = true
                break
            end
        end
        if (not contains) then
            items[toItemName(recipe["Main Output"])] = recipe["Main Output"]
        end
    end

    local options = data.pageTable(items, page)
    local itemCount = data.tableLength(items)

    local finalPage = math.ceil((itemCount) / 10)

    if (finalPage <= 0) then
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("You haven't added any recipes yet!", textSpeed, false)
        ui.waitUntilKey()
        return
    end

    if (looped) then
        --- @diagnostic disable-next-line: missing-parameter
        clearScreen()
        print("What item do you want to craft?")
        term.setTextColor(colors.lightGray)
        print("(Page "..page.." out of "..finalPage..")")
        term.setTextColor(colors.white)
    else
        ui.basic.clearScreen(1 / textSpeed)
        ui.basic.slowPrint("What item do you want to craft?", textSpeed, true)
        term.setTextColor(colors.lightGray)
        ui.basic.slowPrint("(Page "..page.." out of "..finalPage..")", textSpeed, true)
        term.setTextColor(colors.white)
    end

    local picked = ui.pagedListInput(options, textSpeed)

    if (picked <= 10) then
        return items[options[picked]], options[picked]
    elseif (picked == 11) then
        if (page == finalPage) then
            return pickItem(1, true)
        else
            return pickItem(page + 1, true)
        end
    elseif (picked == 12) then
        if (page == 1) then
            return pickItem(finalPage, true)
        else
            return pickItem(page - 1, true)
        end
    end
end

function findRecipe(item)
    for name, recipe in pairs(recipes) do
        if (recipe["Main Output"] == item and recipe["Primary"]) then
            return recipe, name
        end
    end
end

function craftCalc(wishlist)
    ::start::
    local active = false
    for item, desired in pairs(wishlist) do
        recipe = findRecipe(item)

        if (desired == 0) then
            wishlist[item] = nil
        end

        if ((not recipe) or desired <= 0) then
            goto skip
        end

        active = true

        local batches = 1 -- For testing

        for _, package in pairs(recipe["Inputs"]) do
            wishlist[package["Item"]] = (wishlist[package["Item"]] or 0) + package["Count"] * batches
        end
        if (recipe["Catalysts"]) then
            for _, package in pairs(recipe["Catalysts"]) do
                wishlist[package["Item"]] = (wishlist[package["Item"]] or 1)
            end
        end
        for _, package in pairs(recipe["Outputs"]) do
            wishlist[package["Item"]] = (wishlist[package["Item"]] or 0) - package["Count"] * batches
        end

        ::skip::
    end

    if (active) then
        goto start
    end
end

function showWishlist(wishlist, desiredItem, desiredAmount)
    local leftovers = {}
    leftovers[desiredItem] = (leftovers[desiredItem] or 0) + desiredAmount

    for item, amount in pairs(wishlist) do
        if (amount < 0) then
            leftovers[item] = -amount
            wishlist[item] = nil
        end
    end

    ui.basic.clearScreen(1 / textSpeed)
    ui.basic.slowPrint("Crafting: "..toItemName(desiredItem).." x"..desiredAmount, textSpeed, true)
    ui.basic.slowPrint("\nRequired Items\n", textSpeed, true)

    for item, amount in pairs(wishlist) do
        ui.basic.slowPrint("- "..toItemName(item).." x"..amount, textSpeed, true)
    end
    ui.basic.eatInput(textSpeed)
    ui.waitUntilKey()

    ui.basic.clearScreen(1 / textSpeed)
    print("Crafting: "..toItemName(desiredItem).." x"..desiredAmount)
    ui.basic.slowPrint("\nItems Produced\n", textSpeed, true)

    for item, amount in pairs(leftovers) do
        ui.basic.slowPrint("- "..toItemName(item).." x"..amount, textSpeed, true)
    end
    ui.basic.eatInput(textSpeed)
    ui.waitUntilKey()
end

---The API function for other programs to use craftCalc
---@param item string The item to craft
---@param amount integer The amount of the item to craft
---@return table wishlist The calculated wishlist (keys are item IDs, positve values are amounts needed, and negative values are amounts received)
function API(item, amount)
    local wishlist = {}
    wishlist[item] = amount

    craftCalc(wishlist)

    wishlist[item] = (wishlist[item] or 0) - amount
    return wishlist
end

---------------- The stuff that actually gets run ----------------

if fs.exists("craftCalc/recipes.txt") then
    recipes = data.loadData(saveFile)
else
    data.saveData(recipes, saveFile)
end

mainMenu()
ui.basic.clearScreen(1 / textSpeed)

return {
    craftCalc = API
}
