--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

-- Screen Clearing --

function clearScreen()
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	sleep(0.15)
end

function clearLine()
    local x,y = term.getCursorPos()
    term.setCursorPos(1,y-1)
    term.clearLine()
end

-- Menu Making Toolkit --

function errorMessage(message)
    printError("\n"..message)
    sleep(0.75)
    clearLine()
    clearLine()
end

function waitUntilKey()
    term.setTextColor(colors.lightGray)
    print("\nPress any key")
    term.setTextColor(colors.white)
    
    os.pullEvent("key")
    clearLine()
    clearLine()
end

function binaryInput()
    term.setTextColor(colors.lightGray)
    print("\nY/N")
    term.setTextColor(colors.white)

	while(true) do
        local _, key = os.pullEvent("key")
		
		if (keys.getName(key) == "y") then
			return true
		elseif (keys.getName(key) == "n") then
			return false
		end

		errorMessage("Press one of the keys shown.")
	end
end

function textInput()
    term.setTextColor(colors.lightGray)
    write("\n> ")
    local input = string.lower(read())
    term.setTextColor(colors.white)

    return input
end

function numberInput()
    while (true) do
        local input = tonumber(textInput())

        if (input == "nil") then
			errorMessage("Input a number.")
		else
			return input
		end
    end
end

function unfinished()
    clearScreen()
    
    print("This part isn't done being coded.\nPlease try again later.")
    waitUntilKey()
end

-- Variable Using Toolkit --

function toTitleCase(inputString)
    inputString = string.gsub(" "..inputString, "%W%l", string.upper):sub(2)

    return inputString
end

function printFile(filePath)
	local file = fs.open(filePath, "r")
    local line = file.readLine()

    while (line) do
        print(line)

        line = file.readLine
    end

    file.close()
end

function mergeItemString(itemType, itemAmount)
    local itemString = itemType..": "..tostring(itemAmount)

    return itemString
end

function splitItemString(itemString)
    local leftMarker, rightMarker = string.find(itemString, ": ")
    local itemType = string.sub(itemString, 1, leftMarker-1)
    local itemAmount = string.sub(itemString, string.len(itemString), rightMarker+1)

    return itemType, itemAmount
end

function findItem(desiredItem, filePath)
	local file = fs.open(filePath, "r")
    if (file == nil) then
        return nil
    end
    local line = file.readLine()
    
    while (line) do
        local itemType = splitItemString(line)
        if (itemType == desiredItem) then
            return line
        end
        
        line = file.readLine
    end

    return nil
end

-- Root of it all --

function mainMenu()
    clearScreen()
    
    print("What do you want to do?\n")
    term.setTextColor(colors.lightGray)
    print("[1] Add new recipe\n[2] Calculate ingredients\n[0] Exit Program")
    term.setTextColor(colors.white)

    while true do
        local _, key = os.pullEvent("key")
        if (keys.getName(key) == "zero") then
			return
        elseif (keys.getName(key) == "one") then
            addMode()
        elseif (keys.getName(key) == "two") then
            craftMode()
        else
            errorMessage("Press one of the keys shown.")
        end
    end
end

function addMode()
    local fileName, recipeName = addMainOutput()
    addInputs(fileName, recipeName)

    unfinished()

    mainMenu()
end

function craftMode()
    unfinished()

    mainMenu()
end

-- Add Mode Workings --

function addMainOutput()
    clearScreen()
	print("What item is recipe designed to create?")
    local itemType = textInput()

    itemType = toTitleCase(itemType)
    local fileName = "recipes/"..string.gsub(itemType, " ", "_")

    if (fs.exists(fileName)) then
        overwrite(fileName, itemType)
    end

    clearScreen()
    print("How many copys of \""..itemType.."\" does this recipe create?")
    local itemAmount = numberInput()

	-- fs.makeDir(fileName)
	local file = fs.open(fileName.."/Outputs.txt", "w")
    
	file.writeLine(mergeItemString(itemType, itemAmount))
	file.close()

    return fileName, itemType
end

function overwrite(fileName, recipeName)
    clearScreen()
    print("A recipe for \""..recipeName.."\" already exists.\nShould it be overwriten?")

    if (not binaryInput()) then
        mainMenu()
    end

    clearScreen()
    fs.delete(fileName)
	print("\""..fileName.."\" was deleted.")
    waitUntilKey()
end

function listInputs(filePath)
    if (fs.exists(filePath)) then
        print("\nCurrent inputs:")
        printFile(filePath)
    end
end

function addInputs(fileName, recipeName)
    while (true) do
        local loop = true
        local itemType = ""
        while (loop) do
            loop = false
            clearScreen()
            print("What type of items do you need to make \""..recipeName.."\"?")
            listInputs(fileName.."/Inputs.txt")
            itemType = textInput()

            if (findItem(itemType, fileName.."/Inputs.txt")) then
                errorMessage("That item was already added to the recipe.")
                loop = true
            end
        end

        clearScreen()
        print("How many copys of \""..itemType.."\" are needed to make \""..recipeName.."\"?")
        listInputs(fileName.."/Inputs.txt")
        local itemAmount = numberInput()

        local file = fs.open(fileName.."/Inputs.txt", "a")
        file.writeLine(mergeItemString(itemType, itemAmount))

        clearScreen()
        print("Is this all the items do you need to make \""..recipeName.."\"?")
        listInputs(fileName.."/Inputs.txt")
        if (binaryInput()) then
            return
        end
    end
end

-- Craft Mode Workings --

-- Not Functions --

mainMenu()

clearScreen()
print("Goodbye")
waitUntilKey()
clearScreen()