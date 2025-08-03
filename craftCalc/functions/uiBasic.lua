--- @diagnostic disable: undefined-global, undefined-field, lowercase-global

---Clears the screen with a configurable delay
---@param delay integer Seconds to delay after clearing the screen
function clearScreen(delay)
    delay = delay or 0

	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	sleep(delay)
end

---Clears a single line
---(Warning, expects the cursor to be a line below the line you want to clear)
function clearLine()
    local x,y = term.getCursorPos()
    term.setCursorPos(1,y-1)
    term.clearLine()
end

---Slowly writes text to the screen
---@param text string Text to write
---@param textSpeed integer? How many characters to write per second (Default: 20)
---@param carryThough boolean? Prevents eating inputs if true
function slowWrite(text, textSpeed, carryThough)
    local keyPressed = false
    textSpeed = textSpeed or 20

    for n = 1, #text do
        -- Sleep only if key hasn't been pressed yet
        if not keyPressed then
            -- Start a short timer (for non-blocking wait)
            local timer = os.startTimer(1 / textSpeed)

            while true do
                local event, param = os.pullEvent()
                if event == "key" then
                    keyPressed = true

                    if carryThough then
                        os.queueEvent(event, param)
                    end

                    break
                elseif event == "timer" and param == timer then
                    break
                end
            end
        end

        write(text:sub(n, n))
    end
end

---Slowly writes text to the screen followed by a newline
---@param text string Text to write
---@param textSpeed integer How many characters to write per second
---@param carryThough boolean? Prevents eating inputs if true
function slowPrint(text, textSpeed, carryThough)
    slowWrite(text.."\n", textSpeed, carryThough)
end

---Waits for a number of seconds but can be skipped by pressing any button
---@param seconds integer Seconds to wait for
---@param carryThough boolean? Prevents eating inputs if true (Default: true)
function cancellableSleep(seconds, carryThough)
    local timer = os.startTimer(seconds)
    if carryThough == nil then
        carryThough = true
    end

    while true do
        local event, param = os.pullEvent()
        if (event == "key") then
            if carryThough then
                os.queueEvent(event, param)
            end

            break
        elseif (event == "timer" and param == timer) then
            break
        end
    end
end

---Writes a error message then clears it after a delay
---@param message string Text to write
function errorMessage(message)
    printError("\n"..message)
    cancellableSleep(1.5)
    clearLine()
    clearLine()
end

return {
    clearScreen = clearScreen,
    clearLine = clearLine,
    slowWrite = slowWrite,
    slowPrint = slowPrint,
    cancellableSleep = cancellableSleep,
    errorMessage = errorMessage
}