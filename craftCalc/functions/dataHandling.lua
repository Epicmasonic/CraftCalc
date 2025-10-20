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

---Returns the length of a table even if it isn't an array
---@param table table The table to get the length of
function tableLength(table)
    local count = 0

    for _ in pairs(table) do
        count = count + 1
    end

    return count    
end

---Splits a table into pages of 10 keys each
---@param book table The table to make pages out of
---@param page integer What page to return
---@return table subTable Contents of the desired page
function pageTable(book, page)
    local startID = (page - 1) * 10 + 1
    local endID   = page * 10

    local keys = keySort(book)
    local subTable = {}

    for i = startID, math.min(endID, #keys) do
        local key = keys[i]
        subTable[#subTable + 1] = key
    end

    return subTable
end

return {
    saveData = saveData,
    loadData = loadData,
    tableLength = tableLength,
    pageTable = pageTable
}
