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
    Idle = {
        Main = '',
        Sub = '',
        Ammo = '',
        Head = '',
        Ear1 = '',
        Ear2 = '',
        Body = '',
        Hands = '',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = '',
        Waist = '',
        Legs = '',
        Feet = '',
    },
	
	Resting = {
	
	},
		
	TP = {
		Main = '',
        Sub = '',
        Ammo = '',
        Head = '',
        Ear1 = '',
        Ear2 = '',
        Body = '',
        Hands = '',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = '',
        Waist = '',
        Legs = '',
        Feet = '',
    },
	
	WS = {
		Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
	},
	
	Enmity = {
	
	},
	
    Precast = {
	
    },
	
	Nuke = {
		Main = '',
        Sub = '',
        Ammo = '',
        Head = '',
        Ear1 = '',
        Ear2 = '',
        Body = '',
        Hands = '',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = '',
        Waist = '',
        Legs = '',
        Feet = '',
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

    gFunc.EquipSet(sets.BPDown);

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
		elseif string.match(spell.Name, 'Tonko') then
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
        end
    elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke);
	else
		gFunc.EquipSet(sets.SIRD);
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