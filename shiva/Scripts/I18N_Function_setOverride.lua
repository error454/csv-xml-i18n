--------------------------------------------------------------------------------
--  Function......... : setOverride
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function I18N.setOverride ( sOverride )
--------------------------------------------------------------------------------
	
	user.setAIVariable ( this.getUser ( ), "I18N", "sLanguageOverride", sOverride )
	I18N.cleanUp( )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------