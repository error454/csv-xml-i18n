--------------------------------------------------------------------------------
--  Function......... : loadXML
--  Author........... : 
--  Description...... : Loads the given XML file into the hashtable (if not loaded)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function I18N.loadXML ( sXMLFileName )
--------------------------------------------------------------------------------
	
    local hUser = application.getCurrentUser ( )
    local sLanguage = user.getAIVariable ( hUser, "I18N", "sLanguage" )
    local sLanguageOverride = user.getAIVariable ( hUser, "I18N", "sLanguageOverride" )
    local sLocalizedFilename
    
    --
    -- Set the language override if it exists
    --
    if not string.isEmpty ( sLanguageOverride ) then
        sLanguage = sLanguageOverride
    end
    
    --
    -- Make sure the resource is referenced, if not, fall back to english
    --
    if not application.isResourceReferenced ( sXMLFileName .. "-" .. sLanguage, application.kResourceTypeXML ) then
        -- try to fallback to default of en
        if application.isResourceReferenced ( sXMLFileName .. "-en", application.kResourceTypeXML ) then
            log.warning ( "Falling back to english" )
            sLocalizedFilename = sXMLFileName .. "-en"
        else
            log.warning ( "Can't fall back to english!" )
            return 0
        end
    else
        sLocalizedFilename = sXMLFileName .. "-" .. sLanguage
    end
    
    local ht = user.getAIVariable ( hUser, "I18N", "htLoadedFiles" )
    local hXML = user.getAIVariable ( hUser, "I18N", "hXML" )
    
    -- only load the file if it doesn't exist already
    if not hashtable.contains ( ht, sXMLFileName ) then
        xml.empty ( hXML )
        xml.createFromResource ( hXML, sLocalizedFilename )
        
        local hRoot = xml.getRootElement ( hXML )
        
        if(hRoot) then
            local htNewHash = hashtable.newInstance ( )
            for child = 0, xml.getElementChildCount ( hRoot ) - 1 do
                local hChild = xml.getElementChildAt ( hRoot, child )
                local sAttribute = xml.getAttributeValue ( xml.getElementAttributeWithName ( hChild, "name" ) )
                local sValue = xml.getElementValue ( hChild )
                --log.message ( sAttribute, " : ", sValue )
                hashtable.add ( htNewHash, sAttribute, sValue )
            end
            
            hashtable.add ( ht, sXMLFileName, htNewHash )
            log.message ( "Added ", xml.getElementChildCount ( hRoot ), " entries for ", sXMLFileName )
        end
    end
    
    xml.empty ( hXML )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
