--[[

	Kanryu_PLD.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
	TurtleTank = false,
}

--[[ For all sets below you have two options. Static sets, and more complex sync-enabled ones.

		If you care about sync, add _Priority after the name of a set. Such as Idle_Priority instead of Idle. (See example.)
		
		Anything in a {'item1','item2','etc',...}, from high to low will equip based on current level.
		Do not use the bracket format if you don't wish that item to scale.
	]]

local sets = {
    --Use this format if you dont' care about Sync Inheritance
	Idle = {
        Ammo = '',
        Head = '',
        Neck = '',
        Ear1 = '',
        Ear2 = '',
        Body = '',
        Hands = '',
        Ring1 = '',
        Ring2 = '',
        Back = '',
        Waist = '',
        Legs = '',
        Feet = '',
    },
	
	Idle_Refresh = {
	
	},
	
	--[[Example to use this if you care about Sync. 	
	Idle_Priority = {
        Ammo = {'','',},
        Head = {'head1','head2',},
        Neck = {'','',},
        Ear1 = {'','',},
        Ear2 = {'','',},
        Body = {'','',},
        Hands = {'','',},
        Ring1 = {'','',},
        Ring2 = {'','',},
        Back = {'','',},
        Waist = {'','',},
        Legs = {'','',},
        Feet = {'','',},
    },]]
	
	Resting = {
	
	},
	
	TP = {
	
    },
	
	WS = {
	
	},
	
	Enmity = {
	
	},
	
	ShieldBash = {
		
	},
	
	Sentinel = {
	
	},
	
	Rampart = {
	
	},
	
    Precast = {
	
    },	

    Cure = {
	
    },
	
	Nuke = {
		
	},
	
	Recast = {
	
	},

    Enhancing = {
	
    },	
	
	Sneak = {
		Feet = 'Dream Boots +1',
    },
	
	Invisible = {
		Hands = 'Dream Mittens +1',
    },
	
	Movement = {
	
	},
	
}

profile.Sets = sets

profile.Packer = {}

profile.OnLoad = function()
	gSettings.AllowAddSet = true
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /pld /lac fwd')
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /pld /lac fwd')
end

profile.HandleCommand = function(args)
	if (args[1] == 'turtle') then
		if (Settings.TurtleTank == false) then
			gFunc.Echo(158, "Turtle Tanking enabled. Max DT idle set prioritized.")
			Settings.TurtleTank = true;
		else
			gFunc.Echo(158, "Turtle Tanking disabled. Standard DT idle with refresh.")
			Settings.TurtleTank = false;
		end
	end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer()
	
	local myLevel = player.MainJobLevel
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel)
        Settings.CurrentLevel = myLevel
    end	
	
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP);
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting)
    else
		if (Settings.TurtleTank) then
			gFunc.EquipSet(sets.Idle)
		else
			gFunc.EquipSet(gFunc.Combine(sets.Idle,sets.Idle_Refresh))
		end
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(gFunc.Combine(sets.Idle,sets.Movement))
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction()
	
	if (ability.Name == 'Shield Bash') then
        gFunc.EquipSet(gFunc.Combine(sets.Enmity,sets.ShieldBash))
    end
	
	if (ability.Name == 'Sentinel') then
        gFunc.EquipSet(gFunc.Combine(sets.Enmity,sets.Sentinel))
    end
	
	if (ability.Name == 'Rampart') then
        gFunc.EquipSet(gFunc.Combine(sets.Enmity,sets.Rampart))
    end
	
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Silent Oil') then 
		gFunc.EquipSet(sets.Sneak)
	elseif string.match(item.Name, 'Prism Powder') then 
		gFunc.EquipSet(sets.Invisible)
	end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction()
    
	gFunc.EquipSet(sets.Precast)
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction()
	local target = gData.GetActionTarget()
    local player = gData.GetPlayer()

    if spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible)
		else
			gFunc.EquipSet(sets.Enhancing)
        end
    elseif (spell.Skill == 'Healing Magic') then
		gFunc.EquipSet(gFunc.Combine(sets.Enmity,sets.Cure))
	elseif spell.Skill == 'Divine Magic' then
		if string.match(spell.Name, 'Banish') or string.match(spell.Name, 'Holy') then
			gFunc.EquipSet(gFunc.Combine(sets.Enmity,sets.Nuke))
		else
			gFunc.EquipSet(sets.Enmity)
		end
	else
		gFunc.EquipSet(sets.Recast)
    end
	
end

profile.HandleWeaponskill = function()

    local ws = gData.GetAction()
    
    gFunc.EquipSet(sets.WS)
	
end

return profile