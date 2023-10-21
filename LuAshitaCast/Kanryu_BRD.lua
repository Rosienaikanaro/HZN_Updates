--[[

	Kanryu_BRD.lua
	
	8/5/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
	Ring = false,
};

local sets = {
    Idle_Priority = {
        Ammo = {'','',},
        Head = {'','',},
        Neck = {'','',},
        Ear1 = {'','',},
        Ear2 = {'','',},
        Body = {'','',},
        Hands = {'','',},
        Ring1 = {'','',},
        Ring2 = {'','',},,
        Back = {'','',},
        Waist = {'','',},
        Legs = {'','',},
        Feet = {'','',},
    },
	
	Resting_Priority = {
		
	},
	
	TP = {		
		
    },
	
	WS = {
	
    },
	
	SV = {
		--body = "Brd. Cannions +2",
	},

    Precast = {
		
    },
	
	RingLatent = {
	
	},
	
	--Base MAcc Song Gear--
	MAcc = {
	
	},
	
	--Instrument Only--
	Threnody = {
	
	},
	
	--Instrument Only--
	Lullaby = {
	
	},		
	
	--Instrument Only--
	Elegy = {
	
	},	
	
	--Base Song Gear--
	SongCast = {
	
	},
	
	--Instrument Only--
	March = {
	
	},
	
	--Instrument Only--	
	Madrigal = {
	
	},
	
	--Instrument Only--
	Minuet = {
	
	},	
	
	--Instrument Only--
	Paeon = {
	
	},

    Cure = {
	
    },
	
    Cursna = {
	
    },

    Enhancing = {
	
    },

    Recast = {
	
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

local staves = {
    ['Fire'] = 'Vulcan\'s Staff',
    ['Earth'] = 'Earth Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Dark Staff'
};

profile.Sets = sets;

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /brd /lac fwd')
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /brd /lac fwd')
end

profile.HandleCommand = function(args)
	--Ring Toggle Setup--
	if (args[1] == 'ring') then
		if (Settings.RingLatent == false) then
			gFunc.Echo(158, "Minstrel's Ring latent TP enabled.")
			Settings.RingLatent = true;
		else
			gFunc.Echo(158, "Standard casting restored.")
			Settings.RingLatent = false;
		end
	end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end
	
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
    
	if spell.Skill == 'Singing' and Ring then
		gFunc.EquipSet(gFunc.Combine(sets.Precast,sets.RingLatent))
	else
		gFunc.EquipSet(sets.Precast)
	end
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = gData.GetPlayer().Name
	
	if spell.Skill == 'Singing' then
		if string.find(spell.Name, 'Threnody') or string.find(spell.Name, 'Elegy') or string.find(spell.Name, 'Lullaby') then
			if string.find(spell.Name, 'Threnody') then
				gFunc.EquipSet(gFunc.Combine(sets.MAcc, sets.Threnody))
			elseif string.find(spell.Name, 'Elegy') then
				gFunc.EquipSet(gFunc.Combine(sets.MAcc, sets.Elegy))
			elseif string.find(spell.Name, 'Lullaby') then
				gFunc.EquipSet(gFunc.Combine(sets.MAcc, sets.Lullaby))
			end
		else
			if string.find(spell.Name, 'Paeon') then
				gFunc.EquipSet(gFunc.Combine(sets.SongCast, sets.Paeon))
			elseif string.find(spell.Name, 'March') then
				gFunc.EquipSet(gFunc.Combine(sets.SongCast, sets.March))
			elseif string.find(spell.Name, 'Madrigal') then
				gFunc.EquipSet(gFunc.Combine(sets.SongCast, sets.Madrigal))
			elseif string.find(spell.Name, 'Minuet') then
				gFunc.EquipSet(gFunc.Combine(sets.SongCast, sets.Minuet))
			end
		end		
		
    elseif spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
		else
			gFunc.EquipSet(sets.Enhancing);
        end
		
    elseif (spell.Skill == 'Healing Magic') then
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
		else
			gFunc.EquipSet(sets.Cure);
        end
		
	else
		gFunc.EquipSet(sets.Recast);
    end
	
end

profile.HandleWeaponskill = function()

    local ws = gData.GetAction();
    
    gFunc.EquipSet(sets.WS)
	
end

return profile;