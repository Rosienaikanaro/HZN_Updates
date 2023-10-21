--[[

	Kanryu_SMN.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
}

local ninjutsu = {

	Nukes = T{'Doton: Ichi', 'Doton: Ni', 'Doton: San', 'Suiton: Ichi', 'Suiton: Ni', 'Suiton: San', 'Huton: Ichi', 'Huton: Ni', 'Huton: San', 'Katon: Ichi', 'Katon: Ni', 'Katon: San', 'Hyoton: Ichi', 'Hyoton: Ni', 'Hyoton: San', 'Raiton: Ichi', 'Raiton: Ni', 'Raiton: San'};

	Enfeebs = T{'Kurayami: Ichi', 'Kurayami: Ni', 'Hojo: Ichi', 'Hojo: Ni', 'Dokumori: Ichi', 'Jubaku: Ichi'};

};

local sets = {
    Idle_Priority = {
        Ammo = 'Happy Egg',
        Head = 'Emperor Hairpin',
		Neck = {'Peacock Amulet',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Scorpion Harness','Jujitsu Gi',},
        Hands = {'Wonder Mitts',},
        Ring2 = {'Toreador\'s Ring','Jaeger Ring',},
        Ring1 = {'Merman\'s Ring','Rajas Ring','Balance Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt',},
        Legs = {'Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Creek M Clomps','Wonder Clomps',},
    },
	
	Resting = {
	
	},
		
	TP_Priority = {
        Ammo = {'Tiphia Sting',},
        Head = {'Voyager Sallet','Emperor Hairpin',},
		Neck = {'Peacock Amulet',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Stealth Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Haubergeon','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Wonder Mitts','Federation Tekko'},
        Ring1 = {'Rajas Ring',},
        Ring2 = {'Toreador\'s Ring','Jaeger Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Swift Belt','Ryl.Kgt. Belt',},
        Legs = {'Koga Hakama','Ryl.Kgt. Breeches','Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Sarutobi Kyahan','Wonder Clomps',},
    },
	
	WS_Priority = {
        Ammo = {'Bomb Core',},
        Head = {'Voyager Sallet','Emperor Hairpin',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Stealth Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Haubergeon','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Wonder Mitts','Federation Tekko'},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Victory Ring','Courage Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt',},
        Legs = {'Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Creek M Clomps','Wonder Clomps',},
	},
	
	Enmity_Priority = {
		Head = {'Arhat\'s Jinpachi',},
		Body = {'Arhat\'s Gi','Nokizaru Gi',},
		Waist = 'Astral Rope',
	},
	
    Precast_Priority = {
	
    },
	
	Nuke_Priority = {
        Ammo = 'Sweet Sachet',
        Head = '',
		Neck = '',
        Ear1 = 'Cunning Earring',
        Ear2 = 'Moldavite Earring',
        Body = {'Flora Cotehardie','Nokizaru Gi',},
        Hands = '',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = '',
        Waist = {'Ryl.Kgt. Belt',},
        Legs = '',
        Feet = 'Mannequin Pumps',
	},
	
	MAcc_Priority = {
	
	},
	
	Utsusemi_Priority = {
	
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
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)

end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	
	--Level Sync handler
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
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

    if (ability.Name == 'Provoke') then
        gFunc.EquipSet(sets.Enmity);
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
		if string.find(spell.Name, 'Monomi') then
            gFunc.EquipSet(sets.Sneak);
		elseif string.find(spell.Name, 'Tonko') then
            gFunc.EquipSet(sets.Invisible);
		elseif string.find(spell.Name, 'Doton') then
			gFunc.EquipSet(sets.Nuke);
		elseif string.find(spell.Name, 'Suiton') then
			gFunc.EquipSet(sets.Nuke);
		elseif string.find(spell.Name, 'Huton') then
			gFunc.EquipSet(sets.Nuke);
		elseif string.find(spell.Name, 'Katon') then
			gFunc.EquipSet(sets.Nuke);
		elseif string.find(spell.Name, 'Hyoton') then
			gFunc.EquipSet(sets.Nuke);
		elseif string.find(spell.Name, 'Raiton') then
			gFunc.EquipSet(sets.Nuke);
		elseif ninjutsu.Enfeebs:contains(spell.Name) then
			gFunc.EquipSet(sets.MAcc);
		else
			gFunc.EquipSet(sets.Idle);
        end
    elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke);
	else
		gFunc.EquipSet(sets.Idle);
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
    
    gFunc.EquipSet(sets.WS)
	
end

return profile;