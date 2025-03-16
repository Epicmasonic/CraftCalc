function clearScreen()
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	sleep(0.1)
end

function selectMode()
	while (true) do
		clearScreen()
		print("What do you want to do?\n[ Craft | Add | Exit ]\n")
		
		local input = read()
		
		if (string.lower(input) == "craft") then
			craftMode()
		elseif (string.lower(input) == "add") then
			addMode()
		elseif (string.lower(input) == "exit") then
			break
		else
			clearScreen()
			print("I don't know how to do that...")
			sleep(2)
		end
	end
	clearScreen()
end

function askYesNo(question)
	while(true) do
		clearScreen()
		print(question)
		print("[ Y | N ]\n")
		
		answer = string.lower(read())
		
		if (answer == "y") then
			return true
		elseif (answer == "n") then
			return false
		end
		
		clearScreen()
		print("I don't know what you mean")
        sleep(2)
	end
end

function addMode()
	clearScreen()
	print("What recipe do you want to teach me?\n")
	
	local recipe = string.gsub(string.lower(read()), " ", "_")
	
	if (fs.exists("recipes/"..recipe)) then
		if (overwriteRecipe(recipe)) then
			return
		end
	end
	
	fs.makeDir("recipes/"..recipe)
	createItemFile(recipe)
	inputIngredients(recipe)
	
	if (askYesNo("Does this recipe create any byproducts?")) then
		inputByproducts(recipe)
	else
		clearScreen()
	end
	
	print("Thanks for teaching me!")
	sleep(2)
end

function overwriteRecipe(recipe)	
	if (askYesNo("It looks like I already know a recipe for '"..string.gsub(recipe, "_", " ").."'...\n\nWould you like to overwrite it?")) then
		clearScreen()
		print("Alright then!\n")
		fs.delete("recipes/"..recipe)
		print("recipes/"..recipe.." has been deleted.")
		sleep(2)
		return false
	else
		clearScreen()
		print("I'll just send you back to the menu then.")
		sleep(2)
		return true
	end
end

function createItemFile(recipe)
	local file = fs.open("recipes/"..recipe.."/items.txt", "w")
	
	while (true) do
		clearScreen()
		print("How many items does this recipe create?\n")
		input = read()
		print()
		
		if (type(tonumber(input)) == "nil") then
			clearScreen()
			print("That's not a number!")
			sleep(2)
		else
			break
		end
	end
	
	file.writeLine(recipe..": "..-input)
	file.close()
end

function inputIngredients(recipe)
	local file = fs.open("recipes/"..recipe.."/items.txt", "a")
	
	local item = "air"
	local amount = 0
	
	isRepeat = false
	while (true) do
		clearScreen()
		if (isRepeat) then
			print("What other items do you need for this recipe?\n")
		else
			print("What items do you need for this recipe?\n")
		end
		
		item = string.gsub(string.lower(read()), " ", "_")
		
		isLooping = true
		while (isLooping) do
			clearScreen()
			print("How many copys of '"..string.gsub(item, "_", " ").."' are needed?\n")
			amount = string.gsub(string.lower(read()), " ", "_")
			
			if (type(tonumber(amount)) == "nil") then
				clearScreen()
				print("That's not a number!")
				sleep(2)
			else
				isLooping = false
			end
		end
		
		file.writeLine(item..": "..amount)
		
		if (askYesNo("Is that all of the ingredients you want to add?")) then
			break
		end
		isRepeat = true
	end
	
	clearScreen()
	file.close()
end

function inputByproducts(recipe)
	local file = fs.open("recipes/"..recipe.."/items.txt", "a")
	
	local item = "air"
	local amount = 0
	
	isRepeat = false
	while (true) do
		clearScreen()
		if (isRepeat) then
			print("What other byproducts does this recipe create?\n")
		else
			print("What byproducts does this recipe create?\n")
		end
		
		item = string.gsub(string.lower(read()), " ", "_")
		
		isLooping = true
		while (isLooping) do
			clearScreen()
			print("How many copys of '"..string.gsub(item, "_", " ").."' are made?\n")
			amount = string.gsub(string.lower(read()), " ", "_")
			
			if (type(tonumber(amount)) == "nil") then
				clearScreen()
				print("That's not a number!")
				sleep(2)
			else
				isLooping = false
			end
		end
		
		file.writeLine(item..": "..-amount)
		
		if (askYesNo("Is that all of the byproducts you want to add?")) then
			break
		end
		isRepeat = true
	end
	
	clearScreen()
	file.close()
end

function craftMode()
	clearScreen()
	print("What do you want to craft?\n")
	local targetItem = string.gsub(string.lower(read()), " ", "_")

	if (not fs.exists("recipes/"..targetItem)) then
		clearScreen()
		print("It seems I don't know anything about that item...\n\nI'll just send you back to the menu for now.")
		sleep(2)
		return
	end
	
	while (true) do
		clearScreen()
		print("How many of them do you want to make?\n")
		targetAmount = read()
		print()
		
		if (type(tonumber(targetAmount)) == "nil") then
			clearScreen()
			print("That's not a number!")
			sleep(2)
		else
			break
		end
	end
	
	rawMode = askYesNo("Should a wooden axe is equal to 1 log?") -- There is definitely a better way to prase this question :/
	
	clearScreen()
	print("Loading...")
	
	fs.delete("recipes/notepad.txt")
	fs.delete("recipes/wishlist.txt")
	
	file = fs.open("recipes/wishlist.txt", "w")
	file.close()
	
	calculateCraft(targetItem, targetAmount / -findAmountOf("recipes/"..targetItem.."/items.txt", targetItem), rawMode)
	cleanUpWishlist()
	
	clearScreen()
	setUpShopinglistInputs()
	setUpShopinglistOutputs()
	sleep(6)
	
	fs.delete("recipes/wishlist.txt")
end

function findItem(line)
	edge = string.find(line, ": ")-1
	return string.sub(line, 1, edge)
end

function findAmount(line)
	edge = string.find(line, ": ")+2
	return string.sub(line, edge)
end

function findAmountOf(filePath, item)
	local file = fs.open(filePath, "r")
	
	local line = file.readLine()
	
	while (line) do
		if (findItem(line) == item) then
			file.close()
			return findAmount(line)
		end
		line = file.readLine()
	end
	
	file.close()
	return nil
end

function updateList(item, amount)
	local notepad = fs.open("recipes/notepad.txt", "w")
	local file = fs.open("recipes/wishlist.txt", "r")
	
	local line = file.readLine()
	local success = false
	
	while (line) do
		if (findItem(line) == item) then
			notepad.writeLine(item..": "..findAmount(line) + amount)
			success = true
		else
			notepad.writeLine(line)
		end
		
		line = file.readLine()
	end
	
	if (not success) then
		notepad.writeLine(item..": "..amount)
	end
	
	notepad.close()
	file.close()
	
	fs.delete("recipes/wishlist.txt")
	fs.move("recipes/notepad.txt", "recipes/wishlist.txt")
end

function roundUpNearest(number, multiple)
	return math.ceil(number / multiple) * multiple
end

function calculateCraft(recipe, multiplier, rawMode)
	local file = fs.open("recipes/"..recipe.."/items.txt", "r")
	local line = file.readLine()

	local lineAmount = 0
	local lineDesire = 0
	
	while (line) do
		lineAmount = findAmount(line) * multiplier

		updateList(findItem(line), lineAmount)
		
		if (fs.exists("recipes/"..findItem(line).."/items.txt") and tonumber(findAmount(line)) > 0) then
			lineDesire = -findAmountOf("recipes/"..findItem(line).."/items.txt", findItem(line))
			
			if (not rawMode) then
				lineAmount = roundUpNearest(lineAmount, lineDesire)
			end
			
			calculateCraft(findItem(line), lineAmount / lineDesire, rawMode)
		end
		
		line = file.readLine()
	end
	
	file.close()
end

function cleanUpWishlist()
	local notepad = fs.open("recipes/notepad.txt", "w")
	local file = fs.open("recipes/wishlist.txt", "r")
	local line = file.readLine()
	
	while (line) do
		if (findAmount(line) ~= "0") then
			notepad.writeLine(line)
		end
		
		line = file.readLine()
	end
	
	notepad.close()
	file.close()
	
	fs.delete("recipes/wishlist.txt")
	fs.move("recipes/notepad.txt", "recipes/wishlist.txt")
end

function setUpShopinglistInputs()
	local final = fs.open("recipes/craftingCalculatorLog.txt", "w")
	local file = fs.open("recipes/wishlist.txt", "r")
	local line = file.readLine()
	
	final.writeLine("========\n INPUTS\n========\n")
	print("========\n INPUTS\n========\n")
	
	while (line) do
		if (tonumber(findAmount(line)) > 0) then
			final.writeLine(string.gsub(findItem(line), "_", " ")..": "..math.ceil(findAmount(line)))
			print(string.gsub(findItem(line), "_", " ")..": "..math.ceil(findAmount(line)))
		end
		
		line = file.readLine()
	end
	
	final.close()
	file.close()
end

function setUpShopinglistOutputs()
	local final = fs.open("recipes/craftingCalculatorLog.txt", "a")
	local file = fs.open("recipes/wishlist.txt", "r")
	local line = file.readLine()
	
	final.writeLine("\n=========\n OUTPUTS\n=========\n")
	print("\n=========\n OUTPUTS\n=========\n")
	
	while (line) do
		if (tonumber(findAmount(line)) < 0) then
			final.writeLine(string.gsub(findItem(line), "_", " ")..": "..-findAmount(line))
			print(string.gsub(findItem(line), "_", " ")..": "..-findAmount(line))
		end
		
		line = file.readLine()
	end
	
	final.close()
	file.close()
end

function workInProgress()
	clearScreen()
	print("Sorry, I haven't coded this part yet.\n\nMaybe try coming back later?")
	
	sleep(2)
end

selectMode()