local profile = {};

local sets = {
	 Idle = {
        Main = 'Blessed Hammer',
        Sub = '',
        Ammo = '',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = '',
        Body = 'Seer\'s Tunic',
        Hands = 'Seer\'s Mitts +1',
        Ring1 = 'Evoker\'s Ring',
        Ring2 = 'Eremite\'s Ring +1',
        Back = 'Black Cape +1',
        Waist = 'Merc.Cptn. Belt',
        Legs = 'Seer\'s Slacks',
        Feet = '',
    },
	
	Resting = {
		Main = 'Blessed Hammer',
		Body = 'Seer\'s Tunic',
		Legs = 'Baron\'s Slops',
	},
	
	TP = {
	
    },
	
    Precast = {
	
    },

    Cure = {
	
    },
	
    Cursna = {
	
    },

    Enhancing = {
	
    },
	
	Nuke = {
		Main = 'Solid Wand',
        Sub = '',
        Ammo = '',
        Head = 'Seer\'s Crown +1',
        Neck = 'Black Neckerchief',
        Ear1 = 'Cunning Earring',
        Ear2 = '',
        Body = 'Baron\'s Saio',
        Hands = 'Seer\'s Mitts +1',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = 'Black Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Seer\'s Slacks',
        Feet = '',
	},

    SIRD = {
	
	},

    Drain = {
	
    },

	WS = {
	
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

local function HandlePetAction(PetAction)
	
end

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
	
	print(chat.message(''));
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
	
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Holy Water') then 
		gFunc.EquipSet(gcinclude.sets.Holy_Water) 
	end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    
	gFunc.EquipSet(sets.Precast);
	
end

profile.HandleMidcast = function()
	local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);

    if spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
        end
	elseif spell.Skill == 'Healing Magic' then
        gFunc.EquipSet(sets.Cure);
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
	elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke);
    elseif spell.Skill == 'Dark Magic' then
        gFunc.EquipSet(sets.Drain);
	else
		gFunc.EquipSet(sets.SIRD);
    end
   	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
	
end

return profile;