--[[

	Kanryu_SMN.lua
	
	6/8/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)
	
	Updated to fix misc character being included in petAction().name. Tyvm Aramil from LetItBurn discord. 

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
}

local pacts = {

	Skill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};

	Magic = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'};

	Heal = T{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'};

	Hybrid = T{'Flaming Crush','Burning Strike'};

	MAcc = T{'Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};

};

local sets = {
    Idle_Priority = {
        Main = 'Kukulcan\'s Staff',
        Sub = '',
        Ammo = '',
        Head = {'Summoner\'s Horn','Evoker\'s Horn',},
        Neck = 'Smn. Torque',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = {'Yinyang Robe','Evoker\'s Doublet','Seer\'s Tunic',},
        Hands = {'Summoner\'s Brcr.','Evoker\'s Bracers',},
        Ring1 = 'Evoker\'s Ring',
        Ring2 = 'Mermans\'s Ring',
        Back = {'Summoner\'s Cape','Black Cape +1',},
        Waist = 'Hierarch Belt',
        Legs = 'Evoker\'s Spats',
        Feet = {'Smn. Pigaches +1','Evoker\'s Pigaches',},
    },
	
    Pet_Idle_Priority = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',		
		Ear2 = 'Beastly Earring',
		Body = {'Yinyang Robe','Austere Robe',},
		Hands = {'Summoner\'s Bracers','Evoker\'s Bracers',},
		Ring1 = 'Evoker\'s Ring',
		Legs = 'Evoker\'s Spats',
		Feet = {'Smn. Pigaches +1','Evoker\'s Pigaches',},
    },
	
	Resting_Priority = {
		Main = 'Dark Staff',
		Neck = 'Checkered Scarf',
		Body = {'Errant Hpl.','Seer\'s Tunic',},
		Legs = 'Baron\'s Slops',
	},
	
	TP = {
		Neck = 'Peacock Amulet',
		Ear1 = 'Merman\'s Earring',
		Ring2 = 'Jaeger Ring',
		Waist = 'Swift Belt',
    },
	
    Pet_TP_Priority = {
		Head = 'Shep. Bonnet',
		Ear2 = 'Beastly Earring',	
		Hands = 'Summoner\'s Bracers',
		Body = 'Austere Robe',		
		Legs = 'Evoker\'s Spats',
		Feet = 'Smn. Pigaches +1',	
    },

    Precast = {
		
    },
	
	Avacast = {
		Feet = 'Evoker\'s Boots',
    },

    Cure = {
	
    },
	
    Cursna = {
	
    },

    Enhancing = {
	
    },
	
	Nuke = {
		
	},

    SIRD = {
	
	},

    Drain = {
	
    },

	WS = {
	
    },
		
    BPDown = {
		Head = {'Summoner\'s Horn',"Austere Hat",},
		Body = {'Yinyang Robe','Austere Robe',},
		Hands = 'Summoner\'s Brcr.',
		Feet = 'Smn. Pigaches +1',
    },
    
	Siphon = {
	
    },

	PetPhys_Priority = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',
		Hands = 'Summoner\'s Brcr.',
		Legs = 'Evoker\'s Spats',
		Feet = {'Smn. Pigaches +1','Austere Sabots',},	
    },
	
	PetMagic_Priority = {
        Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Hands = 'Summoner\'s Brcr.',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',	
    },
	
	PetWard = {
		Head = {'Evoker\'s Horn','Austere Hat',},
		Neck = 'Smn. Torque',
		Hands = 'Summoner\'s Brcr.',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
	},
    
	PetHealing = {--Avatar HP+
	
    },
	
	PetMAcc_Priority = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Hands = 'Summoner\'s Brcr.',
		Legs = 'Evoker\'s Spats',
		Feet = 'Austere Sabots',
    },
	
    PetHybrid_Priority = {
		Head = {'Evoker\'s Horn','Shep. Bonnet',},
		Neck = 'Smn. Torque',
		Ear2 = 'Beastly Earring',
		Hands = 'Summoner\'s Brcr.',
		Legs = 'Evoker\'s Spats',
		Feet = {'Smn. Pigaches +1','Austere Sabots',},	
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

local summons = {
	['Carbuncle'] = 'Light',
	['Fenrir'] = 'Dark',
	['Ifrit'] = 'Fire',
	['Titan'] = 'Earth',
	['Leviathan'] = 'Water',
	['Garuda'] = 'Wind',
	['Shiva'] = 'Ice',
	['Ramuh'] = 'Thunder',
	['Diabolos'] = 'Dark',
};

profile.Sets = sets;

profile.Packer = {};

local function HandlePetAction(PetAction)
	local BPName = string.sub(PetAction.Name,1,string.len(PetAction.Name)-1);
	if (pacts.Skill:contains(BPName)) then
        gFunc.EquipSet(sets.PetWard);
	elseif (pacts.Magic:contains(BPName)) then
        gFunc.EquipSet(sets.PetMagic);
    elseif (pacts.Hybrid:contains(BPName)) then
        gFunc.EquipSet(sets.PetHybrid);
	elseif (pacts.Heal:contains(BPName)) then
        gFunc.EquipSet(sets.PetHealing);
    elseif (pacts.MAcc:contains(BPName)) then
        gFunc.EquipSet(sets.PetMAcc);
    else
        gFunc.EquipSet(sets.PetPhys);
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
	local zone = gData.GetEnvironment()	
	local DotW = zone.Day
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
    
	if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
	
	if DotW == 'Lightningday' then
		DotW = 'Thunderday'
	end
	
    if player.Status == 'Engaged' then
        gFunc.EquipSet(gFunc.Combine(sets.TP,sets.Pet_TP));
    elseif pet ~= nil and pet.Status == 'Engaged' then
        gFunc.EquipSet(sets.Pet_TP);
		gFunc.Equip('main', staves[summons[pet.Name]])
		if pet.Name == 'Carbuncle' then
			gFunc.Equip('hands', 'Carbuncle Mitts')
		end
		if string.match(DotW, summons[pet.Name]) then
			gFunc.Equip('body', 'Summoner\'s Dblt.')
		end
		if string.match(zone.Weather,summons[pet.Name]) then
			gFunc.Equip('head', 'Summoner\'s Horn')
		end
	elseif pet ~= nil and pet.Status == 'Idle' then
        gFunc.EquipSet(sets.Pet_Idle)
		gFunc.Equip('main', staves[summons[pet.Name]])
		if pet.Name == 'Carbuncle' then
			gFunc.Equip('hands', 'Carbuncle Mitts')
		end
		if string.match(DotW, summons[pet.Name]) then
			gFunc.Equip('body', 'Summoner\'s Dblt.')
		end
		if string.match(zone.Weather,summons[pet.Name]) then
			gFunc.Equip('head', 'Summoner\'s Horn')
		end
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
    local ac = gData.GetBuffCount('Astral Conduit');
    if ac > 0 then return end

    if (ability.Name == 'Release') or (ability.Name == 'Avatar\'s Favor') or (ability.Name == 'Assault') or (ability.Name == 'Retreat') or (ability.Name == 'Apogee') then return end

    gFunc.EquipSet(sets.BPDown);

    if (ability.Name == 'Elemental Siphon') then
        gFunc.EquipSet(sets.Siphon);
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
    
	if spell.Skill == 'Summoning' then
		gFunc.EquipSet(gFunc.Combine(sets.Precast,sets.Avacast))
	else
		gFunc.EquipSet(sets.Precast)
	end
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = gData.GetPlayer().Name
	local petAction = gData.GetPetAction();
	
	if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
	
    if spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
        end
    elseif (spell.Skill == 'Healing Magic') then
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
		else
			gFunc.EquipSet(sets.Cure);
        end
	elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke);
    elseif spell.Skill == 'Summoning' then
        gFunc.EquipSet(sets.SIRD);		
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

    local ws = gData.GetAction();
    
    gFunc.EquipSet(sets.WS)
	
end

return profile;