--[[

	Kanryu_THF.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {}

local Settings = {
    CurrentLevel = 0,
	AccToggle = false,
	THToggle = false,
	MPBodyToggle = false,
}

local gorgets = {

	Soil = T{'Evisceration'};

	Breeze = T{'Shark Bite', 'Dancing Edge'};

};

local sets = {
    Idle_Priority = {
        Ammo = '',
        Head = {'Emperor Hairpin',},
		Neck = {'Evasion Torque','Peacock Amulet',},
        Ear1 = {'Ocl. Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Ethereal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Scorpion Harness','Flora Cotehardie','Rogue\'s Vest','Rapparee Harness','Brigandine','Mrc.Cpt. Doublet',},
        Hands = {'War Gloves +1','Rogue\'s Armlets','Wonder Mitts',},
        Ring1 = {'Breeze Ring','Rajas Ring','Balance Ring',},
        Ring2 = {'Breeze Ring','Deft Ring','Balance Ring',},
        Back = {'Assassin\'s Cape','Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Scouter\'s Rope','Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Crow Hose','Rogue\'s Culottes','Noct Brais +1',},
        --Feet = {'Assassin\'s Pouln.','Rogue\'s Poulaines','Wonder Clomps',},
		Feet = 'Strider Boots',
    },
	
	MP_Body = {
		Body = {'Flora Cotehardie'},
	},
	
	Resting = {
	
	},
	
	TH = {
		Neck = 'Nanaa\'s Charm',
		Hands = 'Assassin\'s Armlets',
	},
		
	TP_Priority = {
        Ammo = '',
        Head = {'Panther Mask','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Love Torque','Peacock Amulet',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Stealth Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Rapparee Harness','Brigandine','Mrc.Cpt. Doublet',}, 
        Hands = {'Dusk Gloves','War Gloves +1','Battle Gloves',},
		Ring1 = {'Rajas Ring',},  
		Ring2 = {'Toreador\'s Ring','Jaeger Ring',},		
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Swift Belt','Mrc.Cpt. Belt',},
        Legs = {'Dragon Subligar','Republic Subligar',},
        Feet = {'Dusk Ledelsens','Leaping Boots',},
    },
	
	TA_Accuracy_Priority = {
		Ammo = '',
        Head = {'Panther Mask','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Love Torque','Peacock Amulet',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Stealth Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Homam Corazza','Scorpion Harness','Rapparee Harness','Brigandine','Mrc.Cpt. Doublet',}, 
        Hands = {'War Gloves +1','Battle Gloves',},
		Ring1 = {'Rajas Ring',},  
		Ring2 = {'Toreador\'s Ring','Jaeger Ring',},		
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Swift Belt','Mrc.Cpt. Belt',},
        Legs = {'Dragon Subligar','Republic Subligar',},
        Feet = {'Dusk Ledelsens','Leaping Boots',},
	},
	
	TP_SA_Priority = {
		Head = {'Hecatomb Cap',},
		Neck = {'Love Torque','Spike Necklace',},
		Ear2 = {'Pixie Earring',},
		Body = {'Dragon Harness','Flora Cotehardie','Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rog. Armlets +1',},
		Ring2 = {'Thunder Ring','Deft Ring',},
		Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Dragon Subligar','Noct Brais +1','Republic Subligar',},
	},
	
	TP_TA_Priority = {
		Head = {'Hecatomb Cap','Emperor Hairpin',},
		Neck = {'Love Torque','Spike Necklace',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Body = {'Dragon Harness','Flora Cotehardie','Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rog. Armlets +1',},
		Ring1 = {'Breeze Ring',},
		Ring2 = {'Breeze Ring','Deft Ring',},
		Back = {'Assassin\'s Cape',},
		Waist = {'Scouter\'s Rope','Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Rogue\'s Culottes','Republic Subligar',},
	},
	
	TP_SATA_Priority = {
		Head = {'Hecatomb Cap',},
		Neck = {'Love Torque','Spike Necklace',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Pixie Earring','Drone Earring',},
		Body = {'Dragon Harness','Flora Cotehardie','Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rog. Armlets +1','Mrc.Cpt. Gloves',},
		Ring2 = {'Thunder Ring','Deft Ring',},
		Back = {'Assassin\'s Cape',},
		Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Dragon Subligar','Rogue\'s Culottes','Republic Subligar',},
	},
	
	WS_Priority = {
		Ammo = '',
        Head = {'Hecatomb Cap','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Love Torque','Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Pixie Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Hecatomb Harness','Dragon Harness','Flora Cotehardie','Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rog. Armlets +1','Mrc.Cpt. Gloves',},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Thunder Ring','Deft Ring','Balance Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Dragon Subligar','Noct Brais +1',},
        Feet = {'Leaping Boots',},
	},
	
	WS_SA_Priority = {
		
	},
	
	WS_TA_Priority = {
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Hands = {'Rog. Armlets +1',},
		Ring1 = {'Breeze Ring',},
		Ring2 = {'Breeze Ring',},
		Back = {'Assassin\'s Cape',},
		Legs = {'Rogue\'s Culottes','Noct Brais +1',},
	},
	
	WS_SATA_Priority = {
		Ear1 = {'Drone Earring',},
		Ear2 = {'Pixie Earring','Drone Earring',},
		Hands = {'Rog. Armlets +1',},
		Back = {'Assassin\'s Cape',},
		Legs = {'Dragon Subligar','Rogue\'s Culottes','Noct Brais +1',},
	},
	
	Enmity = {
	
	},
	
	Steal = {
        Head = 'Rogue\'s Bonnet',
        Body = 'Rogue\'s Vest',
        Hands = 'Rog. Armlets +1',
        Legs = 'Assassin\'s Culottes',
        Feet = 'Rog. Poulaines +1',	
	},
	
	Mug = {
		Head = 'Asn. Bonnet +1',
	},
	
	Flee = {
		Feet = 'Rog. Poulaines +1',
	},
	
	Hide = {
		Feet = 'Rogue\'s Vest',
	},
	
    Precast = {
	
    },
	
	Shot_Priority = {
        Ammo = '',
        Head = {'Emperor Hairpin',},
		Neck = {'Nanaa\'s Charm','Peacock Amulet',},
        Ear1 = {'Drone Earring',},
        Ear2 = {'Drone Earring',},
        Body = {'Noct Doublet +1',},
        Hands = {'Assassin\'s Armlets','Noct Gloves +1',},
        Ring1 = {'Merman\'s Ring','Rajas Ring',}, 
		Ring2 = {'Merman\'s Ring','Jaeger Ring',},  
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Scouter\'s Rope','Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Noct Brais +1',},
        Feet = {'Rog. Poulaines +1','Leaping Boots',},
	},
	
	Sneak = {
		Feet = 'Dream Boots +1',
    },
	
	Invisible = {
		Hands = 'Dream Mittens +1',
    },
	
	Movement = {
		Hands = 'War Gloves +1',
		Feet = 'Strider Boots',
	},
	
};

profile.Sets = sets;

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /thf /lac fwd')
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /thf /lac fwd')
end

profile.HandleCommand = function(args)
	--Accuracy Toggle Setup--
	if (args[1] == 'acc') then
		if (Settings.AccToggle == false) then
			gFunc.Echo(158, "Accuracy based TP enabled. Max Acc TP set prioritized.")
			Settings.AccToggle = true;
		else
			gFunc.Echo(158, "Standard TP restored.")
			Settings.AccToggle = false;
		end
	end
	
	--Treasure Hunter Toggle Setup--
	if (args[1] == 'th') then
		if (Settings.THToggle == false) then
			gFunc.Echo(158, "Treasure Hunter is now prioritized. Equipped at all times.")
			Settings.THToggle = true;
		else
			gFunc.Echo(158, "Standard TH behavior restored.")
			Settings.THToggle = false;
		end
	end
	
	--Refresh Body Toggle Setup--
	if (args[1] == 'mp') then
		if (Settings.MPBodyToggle == false) then
			gFunc.Echo(158, "MP Body equipped. Refreshing mp up to body conversion.")
			Settings.MPBodyToggle = true;
		else
			gFunc.Echo(158, "Standard Idle restored.")
			Settings.MPBodyToggle = false;
		end
	end
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	local sa = gData.GetBuffCount("Sneak Attack")
	local ta = gData.GetBuffCount("Trick Attack")
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
    if player.Status == 'Engaged' then
		if (sa >= 1) and (ta >= 1) then
			gFunc.EquipSet(gFunc.Combine(sets.TP,sets.TP_SATA))
		elseif ta >= 1 then
			gFunc.EquipSet(gFunc.Combine(sets.TP,sets.TP_TA))
		elseif sa >= 1 then
			gFunc.EquipSet(gFunc.Combine(sets.TP,sets.TP_SA))
		elseif Settings.AccToggle then
			gFunc.EquipSet(sets.TA_Accuracy)
		else
			gFunc.EquipSet(sets.TP)
		end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting)
    else
		if Settings.MPBodyToggle then
			gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.MP_Body))
		else
			gFunc.EquipSet(sets.Idle)
		end
    end
	
	if (Settings.THToggle == true) then
		gFunc.EquipSet(sets.TH)
	end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement)
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Steal') then
        gFunc.EquipSet(sets.Steal);
	elseif (ability.Name == 'Mug') then
        gFunc.EquipSet(sets.Mug);
	elseif (ability.Name == 'Flee') then
        gFunc.EquipSet(sets.Flee);
	elseif (ability.Name == 'Hide') then
        gFunc.EquipSet(sets.Hide);
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
		if string.match(spell.Name, 'Monomi: ') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		elseif string.match(spell.Name, 'Tonko: ') and (target.Name == me) then
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
    elseif spell.Skill == 'Enfeebling Magic' then
        gFunc.EquipSet(gFunc.Combine(sets.Idle,sets.TH))
	else
		gFunc.EquipSet(sets.SIRD)
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()
	gFunc.EquipSet(sets.Shot)
end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
	local sa = gData.GetBuffCount("Sneak Attack")
	local ta = gData.GetBuffCount("Trick Attack")
    
    if (sa >= 1) and (ta >= 1) then
		gFunc.EquipSet(gFunc.Combine(sets.WS,sets.WS_SATA))
	elseif ta >= 1 then
		gFunc.EquipSet(gFunc.Combine(sets.WS,sets.WS_TA))
	elseif sa >= 1 then
		gFunc.EquipSet(gFunc.Combine(sets.WS,sets.WS_SA))
	else
		gFunc.EquipSet(sets.WS)
	end
	
	if (gorgets.Soil:contains(ws.Name)) then
		gFunc.Equip('neck','Soil Gorget')
	elseif gorgets.Breeze:contains(ws.Name) then
		gFunc.Equip('neck','Breeze Gorget')
	end
	
end

return profile;