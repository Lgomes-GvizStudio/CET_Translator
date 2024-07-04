
--DisplayscreenMessage
function DisplayMessage(message)

    local MSG = SimpleScreenMessage.new() 
    MSG.message = message  
    MSG.isShown = true  
    MSG.duration = 6.00  
    Game.GetBlackboardSystem():Get(GetAllBlackboardDefs().UI_Notifications):SetVariant(GetAllBlackboardDefs().UI_Notifications.OnscreenMessage, ToVariant(MSG), true)


end

--getTextTranslatedOnTheLine
function getLineFromFile(filename, index)
    -- Open the file in read mode
    local file = io.open(filename, "r")
    if not file then
        return nil, "Error: Unable to open file"
    end
    
    local lineNumber = 1
    local line

    -- Read each line until the desired index
    for currentLine in file:lines() do
        if lineNumber == index then
            line = currentLine
            break
        end
        lineNumber = lineNumber + 1
    end

    file:close()
    return line
end

--CET
--------------------------------------------

--CET ONgameStartEvent
registerForEvent('onInit', function()

    --get uilang
    settings = Game.GetSettingsSystem():GetRootGroup():GetGroups(true) 
    lang_settings = settings[6]:GetVars(true) 
    ui_lang = lang_settings[3] 
    UiLanguage_INT = ui_lang : GetIndex()

    --SetTextTranslations
    Text1 = {
        filename = "Text1.txt";
        

    }

    end)
--CET bindingkey
registerHotkey('Translator', 'Translator', function()

     
    --getline will pull translation of outputfile(outputfilename , UIlanguage +1 )

    --PrintTextOntheline in CET COnsole
    print(getLineFromFile(Text1.filename, UiLanguage_INT+1))

    

    --ScreenMessageExample
    DisplayMessage(getLineFromFile(Text1.filename, UiLanguage_INT+1))
    
end)


