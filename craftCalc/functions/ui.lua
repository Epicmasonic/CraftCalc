--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

local basic = require("functions.uiBasic")
local customBios = require("functions.overcomplicated")

---Asks the user to press any key
function waitUntilKey()
    term.setTextColor(colors.lightGray)
    print("\nPress any key")
    term.setTextColor(colors.white)
    
    os.pullEvent("key")
    basic.clearLine()
    basic.clearLine()
end

---Asks the user for a yes or no
---@return boolean result What the user picked, with true for yes and false for no
function binaryInput()
    term.setTextColor(colors.lightGray)
    print("\nY / N")
    term.setTextColor(colors.white)

	while(true) do
        local _, key = os.pullEvent("key")
		
		if (keys.getName(key) == "y") then
			return true
		elseif (keys.getName(key) == "n") then
			return false
		end

		basic.errorMessage("Press one of the keys shown.")
	end
end

---Asks the user to pick from a list
---@param options table A array of option strings to pick from (Empty strings are skipped)
---@param listSpeed integer Number of seconds to delay writing each option (Default: 20)
---@return integer result The index of the chosen option 
function listInput(options, listSpeed)
    if #options == 0 then
        error("There needs to have at least one option")
    elseif #options > 10 then
        error("There can't be more than ten options")
    end
    listSpeed = listSpeed or 20

    local lastIndex = 0
    local secondLastIndex = 0
    for index, option in ipairs(options) do
        if (option ~= "") then
            secondLastIndex = lastIndex
            lastIndex = index
        end
    end

    term.setTextColor(colors.lightGray)
    print()
    basic.cancellableSleep(1 / listSpeed, false)
    for index, option in ipairs(options) do
        if (option ~= "") then
            if (index == 10) then
                index = 0
            end
            print("["..index.."] "..option)

            if index ~= lastIndex then
                basic.cancellableSleep(1 / listSpeed, index ~= secondLastIndex - 1)
            end
        end
    end
    term.setTextColor(colors.white)

	while true do
        local _, key = os.pullEvent("key")
        local keyName = keys.getName(key)

        if ((keyName == "one" or keyName == "numPad1") and options[1] ~= "") then
            return 1
        elseif ((keyName == "two" or keyName == "numPad2") and options[2] ~= "" and #options >= 2) then
            return 2
        elseif ((keyName == "three" or keyName == "numPad3") and options[3] ~= "" and #options >= 3) then
            return 3
        elseif ((keyName == "four" or keyName == "numPad4") and options[4] ~= "" and #options >= 4) then
            return 4
        elseif ((keyName == "five" or keyName == "numPad5") and options[5] ~= "" and #options >= 5) then
            return 5
        elseif ((keyName == "six" or keyName == "numPad6") and options[6] ~= "" and #options >= 6) then
            return 6
        elseif ((keyName == "seven" or keyName == "numPad7") and options[7] ~= "" and #options >= 7) then
            return 7
        elseif ((keyName == "eight" or keyName == "numPad8") and options[8] ~= "" and #options >= 8) then
            return 8
        elseif ((keyName == "nine" or keyName == "numPad9") and options[9] ~= "" and #options >= 9) then
            return 9
        elseif ((keyName == "zero" or keyName == "numPad0") and options[10] ~= "" and #options >= 10) then
			return 10
        else
            basic.errorMessage("Press one of the keys shown.")
        end
    end
end

---Asks the user to pick from a list with options to change page
---@param options table A array of option strings to pick from (Empty strings are skipped)
---@param listSpeed integer Number of seconds to delay writing each option (Default: 20)
---@return integer result The index of the chosen option 
function pagedListInput(options, listSpeed)
    if #options == 0 then
        error("There needs to have at least one option")
    elseif #options > 10 then
        error("There can't be more than ten options")
    end
    listSpeed = listSpeed or 20

    term.setTextColor(colors.lightGray)
    print()
    basic.cancellableSleep(1 / listSpeed, false)
    for index, option in ipairs(options) do
        if (option ~= "") then
            if (index == 10) then
                index = 0
            end
            print("["..index.."] "..option)

            if index ~= lastIndex then
                basic.cancellableSleep(1 / listSpeed)
            end
        end
    end
    print"[\16] Next Page"
    basic.cancellableSleep(1 / listSpeed, false)
    print"[\17] Previous Page"

    term.setTextColor(colors.white)

	while true do
        local _, key = os.pullEvent("key")
        local keyName = keys.getName(key)

        if ((keyName == "one" or keyName == "numPad1") and options[1] ~= "") then
            return 1
        elseif ((keyName == "two" or keyName == "numPad2") and options[2] ~= "" and #options >= 2) then
            return 2
        elseif ((keyName == "three" or keyName == "numPad3") and options[3] ~= "" and #options >= 3) then
            return 3
        elseif ((keyName == "four" or keyName == "numPad4") and options[4] ~= "" and #options >= 4) then
            return 4
        elseif ((keyName == "five" or keyName == "numPad5") and options[5] ~= "" and #options >= 5) then
            return 5
        elseif ((keyName == "six" or keyName == "numPad6") and options[6] ~= "" and #options >= 6) then
            return 6
        elseif ((keyName == "seven" or keyName == "numPad7") and options[7] ~= "" and #options >= 7) then
            return 7
        elseif ((keyName == "eight" or keyName == "numPad8") and options[8] ~= "" and #options >= 8) then
            return 8
        elseif ((keyName == "nine" or keyName == "numPad9") and options[9] ~= "" and #options >= 9) then
            return 9
        elseif ((keyName == "zero" or keyName == "numPad0") and options[10] ~= "" and #options >= 10) then
			return 10
        elseif ((keyName == "right" or keyName == "d")) then
			return 11
        elseif ((keyName == "left" or keyName == "a")) then
			return 12
        else
            basic.errorMessage("Press one of the keys shown.")
        end
    end
end

---Asks the user for text input
---@param defaultText string? Text to start the user with
---@param autoComplete function?
---@return string input The inputed text
function textInput(defaultText, autoComplete)
    term.setTextColor(colors.lightGray)
    write("\n> ")
    local input = read(nil, nil, autoComplete, defaultText)
    term.setTextColor(colors.white)

    return input
end

---Asks the user for text input but only allows a select number of keys
---@param allowedKeys table Array of key names that are allowed ("Enter" and "Backspace" are always allowed)
---@param errorMessage string? What to tell the user when they try to use a disallowed character
---@param defaultText string? Text to start the user with
---@param autoComplete function?
---@return string input The inputed text
function limitedTextInput(allowedKeys, errorMessage, defaultText, autoComplete)
    term.setTextColor(colors.lightGray)
    write("\n> ")
    local input = customBios.limitedRead(allowedKeys, errorMessage, nil, nil, autoComplete, defaultText)
    term.setTextColor(colors.white)

    return input
end

---Asks the user for numerical input
---@param defaultNumber string? Number to start the user with
---@return integer input The inputed number
function numberInput(defaultNumber)
    ::start::
    local input = tonumber(limitedTextInput({"0","1","2","3","4","5","6","7","8","9","."}, "Only numbers are allowed.", defaultNumber))

    if (input == nil) then
		basic.errorMessage("Input a number.")
        basic.clearLine()
        basic.clearLine()

        goto start
	end

    return input
end

function itemInput()
    ::start::
    local input = limitedTextInput({"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," ","_",":"}, "Input must be a valid Minecraft item ID.", defaultNumber)

    if (select(2, string.gsub(input, ":", "")) > 1 or (string.match(input, "^:") or string.match(input, ":$"))) then
    	basic.errorMessage("Input must be a valid Minecraft item ID.")
        basic.clearLine()
        basic.clearLine()

        goto start
	end

	return toItemID(input)
end

function toItemID(item)
    item = string.lower(item)
    item = string.gsub(item, " ", "_")

    if (select(2, string.gsub(item, ":", "")) == 0) then
        item = "minecraft:"..item
    end

    return item
end

function toItemName(item)
    item = string.gsub(item, "^.*:", "")
    item = string.gsub(item, "_", " ")
    item = toTitleCase(item)
    
    return item
end

function toTitleCase(string)
    local nonCapitalized = {"a", "an", "the", "of", "on", "in", "and", "but", "or"}

    string = string.gsub(string, "(%a)([%w_]*)", function(first, rest)
        local word = first .. rest

        for _, badWord in ipairs(nonCapitalized) do
            if (string.lower(word) == badWord) then
                return word
            end
        end

        return string.upper(first) .. rest
    end)

    return string
end

---Writes out a whole file
---@param filePath string The path of the file to write
function printFile(filePath)
	local file = fs.open(filePath, "r")
    local line = file.readLine()

    while (line) do
        print(line)

        line = file.readLine()
    end

    file.close()
end

return {
    unfinished = unfinished,

    waitUntilKey = waitUntilKey,
    binaryInput = binaryInput,
    listInput = listInput,
    pagedListInput = pagedListInput,

    textInput = textInput,
    limitedTextInput = limitedTextInput,
    numberInput = numberInput,
    itemInput = itemInput,

    toTitleCase = toTitleCase,
    toItemID = toItemID,
    toItemName = toItemName,

    basic = basic

}
