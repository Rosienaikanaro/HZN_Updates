--[[

	Kanryu_DRG.lua
	
	6/17/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
}

local sets = {
    Idle_Priority = {
        Main = {'','',},
        Sub = '',
        Ammo = '',
        Head = '',
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
	
	Resting = {
	
	},
		
	TP_Priority = {
		Main = '',
        Sub = '',
        Ammo = '',
        Head = '',
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
	
	WS_Priority = {
		Main = '',
        Sub = '',
        Ammo = '',
        Head = '',
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
	
	Wheeling_Priority = {
	
	},
	
	Impulse_Priority = {
	
	},
	
	CallWyvern_Priority = {
	
	},
	
	AncientCircle_Priority = {
	
	},
	
    Jump_Priority = {
	
	},
	
	HighJump_Priority = {
	
	},
	
    SpiritLink_Priority = {
	
	},    
	
    SteadyWing_Priority = {
	
	},
	
    Angon_Priority = {
	
	},
	
	HealingBreath_Priority = {
	
	},
	
	Precast_Priority = {
	
	},

    SIRD = {
	
	},
	
	Sneak = {
		Feet = 'Dream Boots +1',
    },
	
	Invisible = {
		Hands = 'Dream Mittens +1',
    },
	
	Movement = {
	
	},
	
};

profile.Sets = sets;

local function HandlePetAction(PetAction)
	local name = string.sub(PetAction.Name,1,string.len(PetAction.Name)-1);
	
	if string.match(spell.Name, 'Healing Breath') then
        gFunc.EquipSet(sets.HealingBreath);
    end
end

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)

end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	local pet = gData.GetPet();
	local petAction = gData.GetPetAction();
	
	--Level Sync handler
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
	--Pet Action Handler
	if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
	
	--Standard Gear change setups
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP);
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
		gFunc.EquipSet(sets.Idle);
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Call Wyvern') then
        gFunc.EquipSet(sets.CallWyvern);
	elseif (ability.Name == 'Ancient Circle') then
        gFunc.EquipSet(sets.AncientCircle);
	elseif (ability.Name == 'Jump') then
        gFunc.EquipSet(sets.Jump);
	elseif (ability.Name == 'Spirit Link') then
        gFunc.EquipSet(sets.SpiritLink);
	elseif (ability.Name == 'High Jump') then
        gFunc.EquipSet(sets.HighJump);
	elseif (ability.Name == 'Steady Wing') then
        gFunc.EquipSet(sets.SteadyWing);
	elseif (ability.Name == 'Angon') then
        gFunc.EquipSet(sets.Angon);
    end
	
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Silent Oil') then 
		gFunc.EquipSet(sets.Sneak);
	elseif string.match(item.Name, 'Prism Powder') then 
		gFunc.EquipSet(sets.Invisible);
	end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    
	gFunc.EquipSet(sets.Precast);
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = gData.GetPlayer().Name

    if spell.Skill == 'Ninjutsu' then
		if string.match(spell.Name, 'Monomi: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		elseif string.match(spell.Name, 'Tonko: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible)
		else
			gFunc.EquipSet(sets.Idle)
        end
	elseif spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
        end
	else
		gFunc.EquipSet(sets.SIRD)
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
    
    if (ws.Name == "Wheeling Thrust") then
		gFunc.EquipSet(sets.Wheeling)
	elseif (ws.Name == "Impulse Drive") then
		gFunc.EquipSet(sets.Impulse)
	else
		gFunc.EquipSet(sets.WS)
	end
	
end

return profile;