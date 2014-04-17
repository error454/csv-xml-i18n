--------------------------------------------------------------------------------
--  Function......... : getString
--  Author........... : 
--  Description...... : Fetch the given string, sStringToGet is in the format "File.name"
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function I18N.getString ( sStringToGet )
--------------------------------------------------------------------------------
	
    local sLanguage = user.getAIVariable ( application.getCurrentUser ( ), "I18N", "sLanguage" )
    if sLanguage == "" then
        log.warning ( "System language is not set, make sure I18N is loaded before other user AI" )
    end
    
    --
    -- Split the input argument at '.'
    --
	local sFile, sString
    local tSplit = table.newInstance ( )
    string.explode ( sStringToGet, tSplit, "." )
    
    if table.getSize ( tSplit ) ~= 2 then
        log.warning ( "Invalid argument passed to getString: ", sStringToGet )
        return nil
    end
    
    sFile = table.getFirst ( tSplit )
    sString = table.getLast ( tSplit )
    
    --
    -- Load the XML into our hash of hashes if it isn't loaded
    --
    I18N.loadXML ( sFile )
    
    --
    -- return the desired string
    --
    local ht = user.getAIVariable ( application.getCurrentUser ( ), "I18N", "htLoadedFiles" )
    
    local innerHash = hashtable.get ( ht, sFile )
    return innerHash and hashtable.get ( innerHash, sString ) or ""
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
