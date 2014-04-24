--------------------------------------------------------------------------------
--  Function......... : getSystemLanguage
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function I18N.getSystemLanguage ( )
--------------------------------------------------------------------------------
	
    -- This follows ISO 639-1
	local sLanguage = system.getOSLanguage ( )
    
    if sLanguage == system.kLanguageAlbanian             then this.sLanguage ( "sq" )
    elseif sLanguage == system.kLanguageArabic           then this.sLanguage ( "ar" )
    elseif sLanguage == system.kLanguageBulgarian        then this.sLanguage ( "bg" )
    elseif sLanguage == system.kLanguageCatalan          then this.sLanguage ( "ca" )
    elseif sLanguage == system.kLanguageCzech            then this.sLanguage ( "cs" )
    elseif sLanguage == system.kLanguageDanish           then this.sLanguage ( "da" )
    elseif sLanguage == system.kLanguageDutch            then this.sLanguage ( "nl" )
    elseif sLanguage == system.kLanguageEnglish          then this.sLanguage ( "en" )
    elseif sLanguage == system.kLanguageFinnish          then this.sLanguage ( "fi" )
    elseif sLanguage == system.kLanguageFrench           then this.sLanguage ( "fr" )
    elseif sLanguage == system.kLanguageGerman           then this.sLanguage ( "de" )
    elseif sLanguage == system.kLanguageGreek            then this.sLanguage ( "el" )
    elseif sLanguage == system.kLanguageHebrew           then this.sLanguage ( "he" )
    elseif sLanguage == system.kLanguageHungarian        then this.sLanguage ( "hu" )
    elseif sLanguage == system.kLanguageIcelandic        then this.sLanguage ( "is" )
    elseif sLanguage == system.kLanguageItalian          then this.sLanguage ( "it" )
    elseif sLanguage == system.kLanguageJapanese         then this.sLanguage ( "ja" )
    elseif sLanguage == system.kLanguageKorean           then this.sLanguage ( "ko" )
    elseif sLanguage == system.kLanguageNorwegian        then this.sLanguage ( "nb" ) -- also listed as nn but google translate does not recognize nn
    elseif sLanguage == system.kLanguagePolish           then this.sLanguage ( "pl" )
    elseif sLanguage == system.kLanguagePortuguese       then this.sLanguage ( "pt" )
    elseif sLanguage == system.kLanguageRomanian         then this.sLanguage ( "ro" )
    elseif sLanguage == system.kLanguageRussian          then this.sLanguage ( "ru" )
    elseif sLanguage == system.kLanguageSerboCroatian    then this.sLanguage ( "hr" )
    elseif sLanguage == system.kLanguageSlovak           then this.sLanguage ( "sk" )
    elseif sLanguage == system.kLanguageSpanish          then this.sLanguage ( "es" )
    elseif sLanguage == system.kLanguageSwedish          then this.sLanguage ( "sv" )
    elseif sLanguage == system.kLanguageThai             then this.sLanguage ( "th" )
    elseif sLanguage == system.kLanguageTurkish          then this.sLanguage ( "tr" )
    elseif sLanguage == system.kLanguageUnknown          then this.sLanguage ( "" )
    elseif sLanguage == system.kLanguageUrdu             then this.sLanguage ( "ur" ) 
    end
	
    log.message ( "System Language is ", this.sLanguage ( ) )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
