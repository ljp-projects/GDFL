local file = io.open(arg[1], 'r')
local gen = io.open(arg[1]:sub(arg[1]:find('%a'), arg[1]:find('%.')).."json", 'w')

gen:write('{\n')

local function toArray(str)
    local arr = {}
    local prevChars = ''
    for i = 1, #str, 1 do
        local char = str:sub(i, i)
        if char ~= ',' then
            prevChars = prevChars..char
        elseif char == ',' then
            arr[#arr + 1] = prevChars
            prevChars = ''
        end
    end
    arr[#arr + 1] = prevChars
    return arr
end

local first = true -- flag to check if it's the first item
for line in io.lines(arg[1]) do
    local text = line
    local next = file:read('*l')
    if next ~= nil then
        local arrS = text:find('<#')
        local arrE = text:find('#>')
        local arr = nil
        local v = nil
        if (arrE ~= nil and arrS ~= nil) then
            arrS = arrS + 2
            arrE = arrE + 1
            arr = text:sub(arrS, arrE)
            arr = arr:gsub('#>', '')
        else
            v = text:sub(text:find('<'), text:find('>'))
        end
        local n = text:sub(text:find('{'), text:find('}'))
        if (arr == nil) then
            v = text:sub(text:find('<'), text:find('>'))
            n = n:gsub('{', '')
            n = n:gsub('}', '')
            v = v:gsub('<', '')
            v = v:gsub('>', '')
        end
        if first and arr == nil then
            v = text:sub(text:find('<'), text:find('>'))
            n = n:gsub('{', '')
            n = n:gsub('}', '')
            v = v:gsub('<', '')
            v = v:gsub('>', '')
            gen:write('\t"'..n..'": "'..v..'"')
            first = false
        elseif first and arr ~= nil then
            v = nil
            n = n:gsub('{', '')
            n = n:gsub('}', '')
            gen:write('\t"'..n..'": [')
            for i = 1, #toArray(arr), 1 do
                if toArray(arr)[i + 1] ~= nil then 
                    gen:write('\n\t\t"'..toArray(arr)[i]..'",')
                else
                    gen:write('\n\t\t"'..toArray(arr)[i]..'"\n\t]')
                end
            end
            first = false
        elseif arr ~= nil then
            v = nil
            n = n:gsub('{', '')
            n = n:gsub('}', '')
            gen:write(',\n\t"'..n..'": [')
            for i = 1, #toArray(arr), 1 do
                if toArray(arr)[i + 1] ~= nil then 
                    gen:write('\n\t\t"'..toArray(arr)[i]..'",')
                else
                    gen:write('\n\t\t"'..toArray(arr)[i]..'"\n\t]')
                end
            end
        else
            gen:write(',\n\t"'..n..'": "'..v..'"')
        end
    end
end

gen:write('\n}')

file:close()
gen:close()
