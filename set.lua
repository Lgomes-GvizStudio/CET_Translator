--StartTranslatorOnCompile
function compile_and_execute(textInput,SrcINT,TargetINT)
    
    local text_to_translate = textInput
    local sourceIndex = SrcINT
    local targetIndex = TargetINT

    -- Check if command-line arguments are provided (for flexibility)
    if arg[1] and arg[2] then
        sourceIndex = tonumber(arg[1]) or sourceIndex
        targetIndex = tonumber(arg[2]) or targetIndex
        text_to_translate = arg[3] or text_to_translate
    end

    -- Load and execute translation script
    local command = string.format("php translator.php %d %d \"%s\"", sourceIndex, targetIndex, text_to_translate)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result
end

--set the string you want to translate
Text1 = "translator"
--set the language that is written, read at GameLanguageIndex.txt
SrcINT = 1
--Set CET_translator outputfilename
outputfile = "Text1.txt"


-- Write text to a file.txt
local file = io.open(outputfile, "w")

--add on everyline
for i = 0, 18 do
    -- Perform actions using index `i`
    print("Translating Index:", i)
    --SetTranslatedTextForLine
    loopstring = compile_and_execute(Text1,SrcINT,i)
    file:write(loopstring , "\n")
    
end

file:close()