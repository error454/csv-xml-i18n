--
-- As found here: http://lua-users.org/wiki/LuaCsv
-- With a minor addition to bail out if the line is nil
--
function ParseCSVLine (line,sep)
    if not line then return nil end
    local res = {}
    local pos = 1
    sep = sep or ','
    while true do
        local c = string.sub(line,pos,pos)
        if (c == "") then break end
        if (c == '"') then
            -- quoted value (ignore separator within)
            local txt = ""
            repeat
                local startp,endp = string.find(line,'^%b""',pos)
                txt = txt..string.sub(line,startp+1,endp-1)
                pos = endp + 1
                c = string.sub(line,pos,pos)
                if (c == '"') then txt = txt..'"' end
                -- check first char AFTER quoted string, if it is another
                -- quoted string without separator, then append it
                -- this is the way to "escape" the quote char in a quote. example:
                --   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
            until (c ~= '"')
            table.insert(res,txt)
            assert(c == sep or c == "")
            pos = pos + 1
        else
            -- no quotes used, just look for the first separator
            local startp,endp = string.find(line,sep,pos)
            if (startp) then
                table.insert(res,string.sub(line,pos,startp-1))
                pos = endp + 1
            else
                -- no separator found -> use rest of string and terminate
                table.insert(res,string.sub(line,pos))
                break
            end
        end
    end
    return res
end

--
-- Input a CSV file and output some broken up arrays containing:
-- language code
-- language name
-- text direction
-- content as multidimensional array
--
function ParseLanguageCSV(file)
    local languageCode, languageName, textDirection
    local textArray = {}
    local hCSV = io.open(file, "r")
    
    if not hCSV then 
        print ("Could not open file: ", file)
        return nil 
    end
    io.input(hCSV)

    languageCode = ParseCSVLine(io.read())
    languageName = ParseCSVLine(io.read())
    textDirection = ParseCSVLine(io.read())

    --
    -- Read all remaining lines into 2D array
    --
    repeat
        local t = ParseCSVLine(io.read())
        if t then
            table.insert(textArray, t)
        end
    until not t
    io.close(hCSV)

    return languageCode, languageName, textArray, textDirection
end


--
-- Generates xml files for each language code containing the given strings. Text direction currently not
-- used.
--
function GenerateLanguageXML( languageCode, languageName, textArray, textDirection )
    
    if not languageCode then return 0 end
    
    local bStartFound = false
    local nStartIndex
    local nStopIndex

    for i = 1, #textArray do
        local currentLine = textArray[i]
        if currentLine[1] == "" or i == #textArray then
            if not bStartFound then
                bStartFound = true
                nStartIndex = i + 1
            else
                nStopIndex = (i == #textArray) and i or i - 1

                -- For each language code
                -- The data looks as follows with the first entry being a header:
                -- language code, sq, ar, bg, ca...
                for languageI = 2, #languageCode do -- data starts at index 2 as you can see

                    local bAllFieldsEmpty = true
                    for fieldI = nStartIndex + 1, nStopIndex do
                        local str = textArray[fieldI][languageI]
                        if str and string.len(str) > 0 then
                            bAllFieldsEmpty = false
                            break
                        end
                    end

                    if not bAllFieldsEmpty then
                        -- Language Code and filename
                        local sCode = languageCode[languageI]
                        local fileName = textArray[nStartIndex][1] .. "-" .. sCode .. ".xml"

                        -- Loop through all of the fields and write out the file
                        local file = io.open(fileName, "w+")
                        io.output(file)

                        -- Header
                        io.write('<?xml version="1.0" encoding="utf-8" ?>\n')
                        io.write('<resources>\n')

                        -- Loop through the body and get all the data entries for this language code
                        -- Date looks like:
                        -- ScoreList,
                        -- title1, Title
                        -- title2, Blah
                        print (fileName, " ", nStopIndex - nStartIndex, " entries")
                        for fieldI = nStartIndex + 1, nStopIndex do -- startIndex points to the filename header, so + 1
                            -- <string name="title1" >Title</string>
                            io.write( '\t<string name="', textArray[fieldI][1], '" >', textArray[fieldI][languageI] or '', '</string>\n')
                        end

                        -- Footer
                        io.write('</resources>')
                        io.close(file)
                    end
                end
                nStartIndex = i + 1
            end
        end
    end
end

-- Main entry point
local sWorkingFile = arg[1] or "test.csv"
GenerateLanguageXML ( ParseLanguageCSV(sWorkingFile) )
