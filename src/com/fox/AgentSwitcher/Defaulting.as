import com.fox.AgentSwitcher.Controller;
import com.fox.AgentSwitcher.Utils.DruidSystem;
import com.Utils.ID32;
import mx.utils.Delegate;
/*
* ...
* @author fox
*/
class com.fox.AgentSwitcher.Defaulting {
	private var Enabled:Boolean;
	private var DefaultTimeout:Number;
	private var m_Controller:Controller;

	public function Defaulting(cont:Controller) {
		m_Controller = cont;
	}
	public function SetState(state) {
		if (state) {
			if(!Enabled) {
				Enabled = true;
				m_Controller.m_Player.SignalToggleCombat.Connect(SlotToggleCombat, this);
				m_Controller.m_Player.SignalOffensiveTargetChanged.Connect(SlotTargetChanged, this);
			}
			setTimeout(Delegate.create(this, SlotToggleCombat), 2000);
		}
		if (Enabled && !state) {
			Enabled = false;
			m_Controller.m_Player.SignalOffensiveTargetChanged.Disconnect(SlotTargetChanged, this);
			m_Controller.m_Player.SignalToggleCombat.Disconnect(SlotToggleCombat, this);
			clearTimeout(DefaultTimeout);
		}
	}
	public function LockUpdated() {
		if(Enabled && !m_Controller.m_Player.IsInCombat()) SlotToggleCombat();
	}
	private function Default() {
		if (m_Controller.m_Player.GetOffensiveTarget().IsNull() 
		&& !m_Controller.m_Player.IsInCombat()
		&& !m_Controller.m_Proximity.Lock
		&& !m_Controller.m_Proximity.inProximity()) //No Proximity Targets inrange
		{ 
			var AgentID:Number = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent, m_Controller.settingRealSlot, 0);
			if (AgentID) {
				DruidSystem.SwitchToAgent(AgentID, m_Controller.settingRealSlot);
			}
			AgentID = DruidSystem.GetSwitchAgent(m_Controller.settingDefaultAgent2, m_Controller.settingRealSlot2, 0);
			if (AgentID) {
				DruidSystem.SwitchToAgent(AgentID, m_Controller.settingRealSlot2);
			}
		}
	}
	private function SlotToggleCombat(combatState:Boolean) {
		clearTimeout(DefaultTimeout);
		if (!combatState) {
			DefaultTimeout = setTimeout(Delegate.create(this, Default), m_Controller.settingDefaultDelay);
		}
	}
	private function SlotTargetChanged(id:ID32) {
		clearTimeout(DefaultTimeout);
		if (id.IsNull()) {
			DefaultTimeout = setTimeout(Delegate.create(this, Default), m_Controller.settingDefaultDelay);
		}
	}
}