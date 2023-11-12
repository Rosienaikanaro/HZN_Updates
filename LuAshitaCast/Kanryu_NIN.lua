--[[

	Kanryu_SMN.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)

]]

local profile = {};

local Settings = {
    CurrentLevel = 0,
	ThunderResist = false,
	FireResist = false,
	LightResist = false,
	IceResist = false,
	EvaTank = false,
	Tank = false,
}

local gorgets = {

	Soil = T{'Blade: Ku','Blade: Ten'};

	Breeze = T{'Blade: Jin',};

};

local ninjutsu = {

	Nukes = T{'Doton: Ichi', 'Doton: Ni', 'Doton: San', 'Suiton: Ichi', 'Suiton: Ni', 'Suiton: San', 'Huton: Ichi', 'Huton: Ni', 'Huton: San', 'Katon: Ichi', 'Katon: Ni', 'Katon: San', 'Hyoton: Ichi', 'Hyoton: Ni', 'Hyoton: San', 'Raiton: Ichi', 'Raiton: Ni', 'Raiton: San'};

	Enfeebs = T{'Kurayami: Ichi', 'Kurayami: Ni', 'Hojo: Ichi', 'Hojo: Ni', 'Dokumori: Ichi', 'Jubaku: Ichi'};

};

local sets = {
    Idle_Priority = {
        Ammo = 'Happy Egg',
        Head = {'Arhat\'s Jinpachi','Emperor Hairpin',},
		Neck = {'Evasion Torque','Peacock Amulet',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Arhat\'s Gi','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Dst. Mittens +1','Wonder Mitts',},
        Ring2 = {'Merman\'s Ring','Toreador\'s Ring','Jaeger Ring',},
        Ring1 = {'Merman\'s Ring','Rajas Ring','Balance Ring',},
        Back = {'Boxer\'s Mantle','Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Koga Sarashi','Ryl.Kgt. Belt',},
        Legs = {'Dst. Subligar +1','Byakko\'s Haidate','Koga Hakama','Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Dst. Leggings +1','Creek M Clomps','Wonder Clomps',},
    },
	
	Tank_Priority = {
		Main = "Terra's Staff",
	},
	
	TR_Priority = {
		Main = "Terra's Staff",
		Range = "Lightning Bow +1",
		Head = "Tsoo\'s Headgear",
		Neck = "Jeweled Collar",
		Ear1 = "Arete del Sol",
		Ear2 = "Arete del Sol",
		Body = "Flora Cotehardie",
		Hands = "Dst. Mittens +1",
		Ring1 = "",
		Ring2 = "",
		Back = "Wolf Mantle +1",
		Waist = "Earth Belt",
		Legs = "Byakko\'s Haidate",
		Feet = "Dst. Leggings +1",
	},
	
	FR_Priority = {
		Main = "Neptune's Staff",
		Head = "Tsoo\'s Headgear",
		Neck = "Jeweled Collar",
		--Ear1 = "Tmph. Earring",
		Ear1 = "Ruby Earring",		
		--Ear2 = "Tmph. Earring",
		Ear2 = "Ruby Earring",		
		Body = "Republic Harness",
		Hands = "Tarasque Mitts +1",
		Ring1 = "Triumph Ring",
		Ring2 = "Victory Ring",
		Back = "Wolf Mantle +1",
		Waist = "Water Belt",
		--Legs = "Dino Trousers",
		Legs = "Raptor Trousers",
		Feet = "Suzaku's Sune-Ate",
	},
	
	LR_Priority = {
		Main = "Terra's Staff",
		Head = "Tsoo\'s Headgear",
		Neck = "Moon Amulet",
		Ear1 = "Arete del Sol",
		Ear2 = "Arete del Sol",
		Body = "Kirin's Osode",
		Hands = "Dst. Mittens +1",
		Ring1 = "Jelly Ring",
		Ring2 = "Merman's Ring",
		Back = "Wolf Mantle +1",
		Waist = "Friar's Rope",
		Legs = "Dst. Subligar +1",
		Feet = "Dst. Leggings +1"
	},
	
	IR_Priority = {
		Main = "Vulcan's Staff",
		Head = "Choplix's Coif",
		Neck = "Jeweled Collar",
		--Ear1 = "Tmph. Earring",
		Ear1 = "Ruby Earring",		
		--Ear2 = "Tmph. Earring",
		Ear2 = "Ruby Earring",		
		Body = "Flora Cotehardie",
		Hands = "",
		Ring1 = "",
		Ring2 = "",
		Back = "Wolf Mantle +1",
		Waist = "Fire Belt",
		--Legs = "Dino Trousers",
		Legs = "",
		Feet = "Kingdom Boots",
	},
	
	Eva_Priority = {
		Main = "Auster's Staff",
		Range = "Ungur Boomerang",
		Head = "Emperor Hairpin",
		Neck = "Evasion Torque",
		Ear1 = "Ocl. Earring",
		Ear2 = "Ethereal Earring",
		Body = "Scorpion Harness",
		Hands = "Rasetsu Tekko +1",
		Ring1 = "Breeze Ring",
		Ring2 = "Breeze Ring",
		Back = "Boxer's Mantle",
		Waist = "Scouter's Rope",
		Legs = "Dst. Subligar +1",
		Feet = "Dance Shoes +1",
	},
	
	Resting = {
		Main = 'Pluto\'s Staff',
	},
		
	TP_Priority = {
        Ammo = {'Tiphia Sting',},
        Head = {'Panther Mask','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Peacock Amulet',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Stealth Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Haubergeon','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Dusk Gloves','Wonder Mitts','Federation Tekko'},
        Ring1 = {'Rajas Ring',},
        Ring2 = {'Toreador\'s Ring','Jaeger Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Swift Belt','Ryl.Kgt. Belt',},
        Legs = {'Byakko\'s Haidate','Koga Hakama','Ryl.Kgt. Breeches','Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Sarutobi Kyahan','Wonder Clomps',},
    },
	
	WS_Priority = {
        Ammo = {'Bomb Core',},
        Head = {'Shr.Znr.Kabuto','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Kirin\'s Osode','Haubergeon','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Wonder Mitts','Federation Tekko'},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Triumph Ring','Victory Ring','Courage Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt',},
        Legs = {'Shura Haidate','Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Creek M Clomps','Wonder Clomps',},
	},
	
	Ku_Priority = {
        Ammo = {'Bomb Core',},
        Head = {'Shr.Znr.Kabuto','Voyager Sallet','Emperor Hairpin',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1',},
        Body = {'Kirin\'s Osode','Haubergeon','Scorpion Harness','Jujitsu Gi',},
        Hands = {'Wonder Mitts','Federation Tekko'},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Triumph Ring','Victory Ring','Courage Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Ryl.Kgt. Belt',},
        Legs = {'Shura Haidate','Ryl.Kgt. Breeches','Republic Subligar',},
        Feet = {'Creek M Clomps','Wonder Clomps',},
	},
	
	Enmity_Priority = {
		Head = {'Arhat\'s Jinpachi',},
		Neck = 'Harmonia\'s Torque',
		Body = {'Arhat\'s Gi','Nokizaru Gi',},
		Back = 'Resentment Cape',
		Waist = 'Astral Rope',
		Feet = 'Yasha Sune-Ate',
	},
	
    Precast_Priority = {
	
    },
	
	Nuke_Priority = {
        Ammo = 'Sweet Sachet',
        Head = 'Koga Hatsuburi',
		Neck = '',
        Ear1 = 'Moldavite Earring',
        Ear2 = {'Stealth Earring','Cunning Earring',},
        Body = {'Kirin\'s Osode','Flora Cotehardie','Nokizaru Gi',},
        Hands = '',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = 'Fed. Army Mantle',
        Waist = {'Koga Sarashi','Ryl.Kgt. Belt',},
        Legs = '',
        Feet = 'Koga Kyahan',
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
    ['Earth'] = 'Terra\'s Staff',
    ['Water'] = 'Neptune\'s Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Apollo\'s Staff',
    ['Dark'] = 'Pluto\'s Staff'
};

profile.Sets = sets;

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /nin /lac fwd')
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /nin /lac fwd')
end

profile.HandleCommand = function(args)
	--Thunder Resist Toggle Setup--
	if (args[1] == 'tr') then
		if (Settings.ThunderResist == false) then
			gFunc.Echo(158, "Thunder Resist is now prioritized. Max Acc TP set prioritized.")
			Settings.ThunderResist = true;
		else
			gFunc.Echo(158, "Thunder Resist disabled.")
			Settings.ThunderResist = false;
		end
	end
	
	--Fire Resist Toggle Setup--
	if (args[1] == 'fr') then
		if (Settings.FireResist == false) then
			gFunc.Echo(158, "Fire Resist is now prioritized. Equipped at all times.")
			Settings.FireResist = true;
		else
			gFunc.Echo(158, "Fire Resist disabled.")
			Settings.FireResist = false;
		end
	end
	
	--Light Resist Toggle Setup--
	if (args[1] == 'lr') then
		if (Settings.LightResist == false) then
			gFunc.Echo(158, "Light Resist is now prioritized. Max Acc TP set prioritized.")
			Settings.LightResist = true;
		else
			gFunc.Echo(158, "Light Resist disabled.")
			Settings.LightResist = false;
		end
	end
	
	--Ice Resist Toggle Setup--
	if (args[1] == 'ir') then
		if (Settings.IceResist == false) then
			gFunc.Echo(158, "Ice Resist is now prioritized. Max Acc TP set prioritized.")
			Settings.IceResist = true;
		else
			gFunc.Echo(158, "Ice Resist disabled.")
			Settings.IceResist = false;
		end
	end
	
	--Eva Toggle Setup--
	if (args[1] == 'eva') then
		if (Settings.EvaTank == false) then
			gFunc.Echo(158, "Evasion is now prioritized. Max Acc TP set prioritized.")
			Settings.EvaTank = true;
		else
			gFunc.Echo(158, "Evasion disabled.")
			Settings.EvaTank = false;
		end
	end
	
	--Tank Toggle Setup--
	if (args[1] == 'tank') then
		if (Settings.Tank == false) then
			gFunc.Echo(158, "Tank equipped. Terra's staff prioritized.")
			Settings.Tank = true;
		else
			gFunc.Echo(158, "Standard Idle behavior restored.")
			Settings.Tank = false;
		end
	end
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
	if Settings.ThunderResist then
		gFunc.EquipSet(sets.TR)
	elseif Settings.FireResist then
		gFunc.EquipSet(sets.FR)
	elseif Settings.LightResist then
		gFunc.EquipSet(sets.LR)
	elseif Settings.IceResist then
		gFunc.EquipSet(sets.IR)
	elseif Settings.EvaTank then
		gFunc.EquipSet(sets.Eva)
	elseif Settings.Tank then
		if (player.Status == 'Resting') then
			gFunc.EquipSet(sets.Resting);
		else
			gFunc.EquipSet(gFunc.Combine(sets.Idle, sets.Tank))
		end
    elseif player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP);
    else
		gFunc.EquipSet(sets.Idle);
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Provoke') or (ability.Name == 'Souleater') or (ability.Name == 'Last Resort') then
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
		elseif ninjutsu.Nukes:contains(spell.Name) then
			gFunc.EquipSet(sets.Nuke);
		elseif ninjutsu.Enfeebs:contains(spell.Name) then
			if Settings.Tank then
				gFunc.EquipSet(sets.Enmity);
			else
				gFunc.EquipSet(sets.MAcc);
			end
		elseif string.find(spell.Name, 'Utsusemi') then
			gFunc.EquipSet(gFunc.Combine(sets.Idle,sets.Precast));
        end
    elseif spell.Skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke);
	elseif spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
        end
	else
		gFunc.EquipSet(sets.Enmity);
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
	
	gFunc.EquipSet(sets.WS)
    
    if (gorgets.Soil:contains(ws.Name)) then
		gFunc.Equip('neck','Soil Gorget')
	elseif gorgets.Breeze:contains(ws.Name) then
		gFunc.Equip('neck','Breeze Gorget')
	end
	
end

return profile;