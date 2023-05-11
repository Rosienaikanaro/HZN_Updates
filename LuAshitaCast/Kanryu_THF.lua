--[[

	Kanryu_THF.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {}

local Settings = {
    CurrentLevel = 0,
}

local sets = {
    Idle_Priority = {
        Ammo = '',
        Head = {'Rogue\'s Bonnet','Emperor Hairpin',},
		Neck = {'Nanaa\'s Charm','Peacock Amulet',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Rogue\'s Vest','Rapparee Harness','Brigandine','Mrc.Cpt. Doublet',},
        Hands = {'War Gloves +1','Rogue\'s Armlets','Wonder Mitts',},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Deft Ring','Balance Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Rogue\'s Culottes','Noct Brais +1',},
        Feet = {'Rogue\'s Poulaines','Wonder Clomps',},
    },
	
	Resting = {
	
	},
		
	TP_Priority = {
        Ammo = '',
        Head = {'Voyager Sallet','Emperor Hairpin',},
		Neck = {'Peacock Amulet',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Rapparee Harness','Brigandine','Mrc.Cpt. Doublet',}, 
        Hands = {'War Gloves +1','Battle Gloves',},
		Ring1 = {'Rajas Ring',},  
		Ring2 = {'Jaeger Ring',},		
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Swift Belt','Mrc.Cpt. Belt',},
        Legs = {'Republic Subligar',},
        Feet = {'Leaping Boots',},
    },
	
	TP_SA_Priority = {
		Neck = {'Spike Necklace',},
		Body = {'Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rogue\'s Armlets',},
		Ring2 = {'Deft Ring',},
		Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Noct Brais +1','Republic Subligar',},
	},
	
	TP_TA_Priority = {
		Head = {'Emperor Hairpin',},
		Neck = {'Spike Necklace',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Body = {'Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Mrc.Cpt. Gloves'},	
		Ring2 = {'Deft Ring',},
		Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Rogue\'s Culottes','Republic Subligar',},
	},
	
	TP_SATA_Priority = {
		Head = {'Emperor Hairpin',},
		Neck = {'Spike Necklace',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Body = {'Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rogue\'s Armlets','Mrc.Cpt. Gloves'},
		Ring2 = {'Deft Ring',},
		Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
		Legs = {'Rogue\'s Culottes','Republic Subligar',},
	},
	
	WS_Priority = {
		Ammo = '',
        Head = {'Voyager Sallet','Emperor Hairpin',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Brigandine','Mrc.Cpt. Doublet',},
		Hands = {'Rogue\'s Armlets','Mrc.Cpt. Gloves',},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Deft Ring','Balance Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Noct Brais +1',},
        Feet = {'Leaping Boots',},
	},
	
	WS_SA_Priority = {
	
	},
	
	WS_TA_Priority = {
		Head = {'Emperor Hairpin',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Legs = {'Rogue\'s Culottes','Noct Brais +1',},
	},
	
	WS_SATA_Priority = {
		Head = {'Emperor Hairpin',},
		Ear1 = {'Drone Earring',},
		Ear2 = {'Drone Earring',},
		Legs = {'Rogue\'s Culottes','Noct Brais +1',},
	},
	
	Enmity = {
	
	},
	
	Steal = {
        Head = 'Rogue\'s Bonnet',
        Body = 'Rogue\'s Vest',
        Hands = 'Rogue\'s Armlets',
        Legs = 'Rogue\'s Culottes',
        Feet = 'Rogue\'s Poulaines',	
	},
	
	Flee = {
		Feet = 'Rogue\'s Poulaines',
	},
	
	Hide = {
		Feet = 'Rogue\'s Vest',
	},
	
    Precast = {
	
    },
	
	Shot_Priority = {
        Ammo = '',
        Head = {'Emperor Hairpin',},
		Neck = {'Peacock Amulet',},
        Ear1 = {'Drone Earring',},
        Ear2 = {'Drone Earring',},
        Body = {'Noct Doublet +1',},
        Hands = {'Noct Gloves +1',},
        Ring1 = {'Rajas Ring',}, 
		Ring2 = {'Jaeger Ring',},  
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt','Mrc.Cpt. Belt',},
        Legs = {'Noct Brais +1',},
        Feet = {'Leaping Boots',},
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

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)

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
		else
			gFunc.EquipSet(sets.TP)
		end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting)
    else
		gFunc.EquipSet(sets.Idle)
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement)
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Steal') then
        gFunc.EquipSet(sets.Steal);
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
		if string.match(spell.Name, 'Monomi: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		elseif string.match(spell.Name, 'Tonko: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible)
        end
    elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke)
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
	
end

return profile;