# AgentSwitcher
With the release of Occult Defence scenario Funcom released bunches of new agents, druids, which give damage bonus against certain species.  
However it can be quite hard to tell what species each enemy are (and it can be  inconsistent), not to mention the time it takes to switch the agent.
So i created this mod, which automatically switches agent in specified slot to match the enemy.  

Agent used:  
* Vampires : Default  
* Construct : Nuala Magorian  
* Cybernetic : Fearghas Abernathy  
* Demon : Laughing Jenny  
* Aquatic : Brann Mac Diarmada  
* Filth : Francis Rowan  
* Human : Lady of Mists  
* Spirit : Amelia Bindings  
* Supernatural : Sif Minervudottir  
* Undead : Lynch  
* Animal : Finn Mulligan  
* Others : Default  

Default agent is automatically set when you switch to a build.


Left-Click the icon to open QuickSelect menu, which contains your last 3 regular agents, and all your level 50 druids  
Right-click the icon to access mod settings  
Icon can be moved while in GUI-Edit mode  
[![Menu](Menu.png "Menu")](https://raw.githubusercontent.com/SecretFox/AgentSwitcher/master/Menu.png)  
	

**Settings**  
Switch on target change : Switches your agent when you target an enemy  
Default on combat end : Switches back to your default agent x seconds after combat ends  
Enable proximity Targeting : Automatically switches agent when specified(see proximiy list below) enemy enters proximity.
________
Agent Slot : Agent slot used for switching (1-3)  
Print Target Race : Prints enemy race on system chat channel when targeting them  
Disable on quickselect : Disables target based switching when quickselecting(left-clicking icon) agent  
Default delay : Wait time for "Default on combat end" option  
Agent display : Creates moveable text which displays currently equipped agent  
Use agent name on display : Whether display should show agents name or damage bonus.  
Use agent name on quickselect : Whether quickselect should show agents name or damage bonus.  
________  
Proximity targeting:  
	Format \<Name\>|\<Agent\>|\<Distance/Trigger\>. Only name is required.  

	Name : Mob name, must be exact match(including capitalization).  
	
	Agent : Overrides agent choice, if left unspecified then agent best suited for the mob type will be used.  
		This can be handy if you need to change agent for dungeon boss, but the adds have different type(e.g DW2, DW6).  
		Valid values: Construct, Cybernetic, Demon, Aquatic, Filth, Human, Spirit, Supernatural, Undead, Animal, Default  
	
	Distance : Mob has to be closer than this distance before proximity switch will trigger  
	Trigger : Currently there is only one trigger, onKill. onKill triggers the switch when the specified target is killed.  
		This can be useful when you don't necessarily have time to target the boss (e.g DW4, DW6, Ankh5).  
		
	Additional Notes:  
		Targeting based switching and defaulting are locked while proximity target is in range, or player has not entered combat after onKill triggered.  
	
________  
Range : When distance is not specified in the proximity list this value will be used  
Rate : How often nametag distance is checked, low values could cause lag?  