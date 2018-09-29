# AgentSwitcher
Automatically switches agent based on enemy species.  
Agent used:  
* Vampires ; Default  
* Construct ; Nuala Magorian  
* Cybernetic ; Fearghas Abernathy  
* Demon ; Laughing Jenny  
* Aquatic ; Brann Mac Diarmada  
* Filth ; Francis Rowan  
* Human ; Lady of Mists  
* Spirit ; Amelia Bindings  
* Supernatural ; Sif Minervudottir  
* Undead ; Lynch  
* Animal ; Finn Mulligan  
* Others; Default  
	
Use `/option AgentSwitcher_Slot x` command to set which passive slot is used.  
When player targets species which they don't have levelled agent for default agent will be used.  
Default agent is automatically set when changing builds(works with boobuilds too) or manually switching agents.  

Use `AgentSwitcher_DefaultOnCombatEnd true`(default false) to enable agent defaulting when combat ends, and you are not targeting anything.  
Unfortunately each time agent gets changed a sounds will be played, so if you use this option i recommend setting low interface audio volume.

`AgentSwitcher_DefaultDelay x` controls delay of previous option, by default it is set to 2000 (2 seconds).  
Too low values and your agent might get changed between attacking mobs.


Use `/option AgentSwitcher_Debug true` to enable debug mode, when debug is enabled mob species is printed on system chat channel when targeting an enemy.  

