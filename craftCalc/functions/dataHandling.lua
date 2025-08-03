--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

---Saves the inputed data to the save file
---@param data any
---@param saveFile string File to load from
function saveData(data, saveFile)
    local file = fs.open(saveFile, "w")
    file.write(textutils.serialise(data))
    file.close()
end

---Returns the data in the save file
---@param saveFile string File to load from
---@return any data Loaded data
function loadData(saveFile)
    local file = fs.open(saveFile, "r")
    local data = textutils.unserialise(file.readAll())
    file.close()

    return data
end

function keySort(unsortedTable)
    local keys = {}

    for key in pairs(unsortedTable) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b) return string.lower(tostring(a)) < string.lower(tostring(b)) end)
    return keys
end

---Splits a table into pages of 10 keys each
---@param book table The table to make pages out of
---@param page integer What page to return
---@return table subTable Contents of the desired page
---@return boolean lastPage Is true if this is the last page
function pageTable(book, page)
    local endID = page * 10
    local startID = endID - 9
    local currentID = 1

    local sortedTable = keySort(book)
    local subTable = {}

    for key, value in ipairs(sortedTable) do
            if (currentID >= startID) then
            table.insert(subTable, key, value)
            if (currentID == endID) then
                break
            end
        end
        currentID = currentID + 1
    end

    return subTable, math.ceil((#book + 1) * 10) / 10 == page
end

return {
    saveData = saveData,
    loadData = loadData,
    pageTable = pageTable
}