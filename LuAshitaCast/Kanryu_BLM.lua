--[[

	Kanryu_BLM.lua
	
	4/11/2023
	
	Kanryu of Ragnarok
	
	LAC Build for Horizon - Requires LACv1.52(2/18/23)
		For an explanation of Priority Sets see the bottom.

]]

local profile = {}

local Settings = {
    CurrentLevel = 0,
}

local EleDoTs = T{'Rasp', 'Drown', 'Choke', 'Burn', 'Frost', 'Shock'}

local MNDEnfeebs = T{'Paralyze', 'Slow'}

local sets = {
    Idle_Priority = {
        Main = {'',},		
        Sub = '',
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
	
	--
	Resting_Priority = {
		Main = {'Dark Staff','Pilgrim\'s Wand',},
		Neck = 'Checkered Scarf',
		Body = {'Errant Hpl.','Seer\'s Tunic',},
		Legs = 'Baron\'s Slops',
	},
	
	TP = {
	
    },

    Precast = {
	
    },
	
	Nuke = {
	
	},
	
	--Comment this out until you get it.
	SorcRing = {
		--Ring1 = 'Sorcerer\'s Ring',
	},
	
	--Comment this out until you get it.
	UggyPendant = {
		--Neck = 'Uggalepih Pendant',
	},
	
	DoTs = {
	
	},
	
	Enfeebling = {
	
	},
	
	MNDEnfeebling = {
	
	},
	
	Drain = {
	
    },

    Cure = {
	
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

local staves = {
	--Update with HQ as you get them.
    ['Fire'] = 'Fire Staff',
    ['Earth'] = 'Earth Staff',
    ['Water'] = 'Water Staff',
    ['Wind'] = 'Wind Staff',
    ['Ice'] = 'Ice Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Dark Staff'
}

local obis = {
	--Uncomment as you get them.
    --['Fire'] = 'Karin Obi',
    --['Earth'] = 'Dorin Obi',
    --['Water'] = 'Suirin Obi',
    --['Wind'] = 'Furin Obi',
    --['Ice'] = 'Hyorin Obi',
    --['Thunder'] = 'Rairin Obi',
    --['Light'] = 'Korin Obi',
    --['Dark'] = 'Anrin Obi'
}

profile.Sets = sets;

profile.Packer = {};

profile.OnLoad = function()
	gSettings.AllowAddSet = true
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)

end

--Default State. Acts as aftercast and state change combined. Constantly checks.
profile.HandleDefault = function()
	local player = gData.GetPlayer()
	
	--Level Sync handler for _Priority sets--
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
	--Standard Aftercast setup--
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.TP)
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting)
    else
		gFunc.EquipSet(sets.Idle)
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement)
	end
	
end

--Precast for Job Ability
profile.HandleAbility = function()
	local ability = gData.GetAction()
	
end

--Precast for Item
profile.HandleItem = function()
    local item = gData.GetAction()

	if string.match(item.Name, 'Silent Oil') then 
		gFunc.EquipSet(sets.Sneak)
	elseif string.match(item.Name, 'Prism Powder') then 
		gFunc.EquipSet(sets.Invisible)
	end
end

--Precast Function
profile.HandlePrecast = function()
    local spell = gData.GetAction()
    
	gFunc.EquipSet(sets.Precast)
	
end

--Midcast Function
profile.HandleMidcast = function()
    local spell = gData.GetAction()
	local target = gData.GetActionTarget()
    local me = gData.GetPlayer().Name

	--Elemental Magic Spells
    if spell.Skill == 'Elemental Magic' then
        if (EleDoTs:contains(spell.Name)) then
			gFunc.EquipSet(sets.EleDots)
		else
			gFunc.EquipSet(sets.Nuke);
			gFunc.Equip('main', staves[spell.Element])
			--UggyPendant Check
			if UggyPendant(spell) then
				gFunc.EquipSet(sets.UggyPendant)
			end
			--SorcRing Check
			if RingActive() then
				gFunc.EquipSet(sets.SorcRing)
			end
			--ObiApplication Check
			if ObiCheck(spell) >= 1 then
				gFunc.Equip('waist', obis[spell.Element])
			end
		end
			
	--Enfeebling Magic Spells
	elseif spell.Skill == 'Enfeebling Magic' then
		--MND Based Enfeebling Trigger
		if (MNDEnfeebs:contains(spell)) then
			gFunc.EquipSet(sets.MNDEnfeebling)
		--Standard Enfeebling Trigger
		else
			gFunc.EquipSet(sets.Enfeebling)
		end
		gFunc.Equip('main', staves[spell.Element])
			
	--Dark Magic Spells
	elseif spell.Skill == 'Dark Magic' then
        gFunc.EquipSet(sets.Drain)
		gFunc.Equip('main', staves[spell.Element])
		--Dark Obi does apply to Drain/Aspir
		if ObiCheck(spell) >= 1 and (string.find(spell.Name, 'Drain') or string.find(spell.Name, 'Aspir')) then
			gFunc.Equip('waist', obis[spell.Element])
		end
	
	--Enhancing Magic Spells
	elseif spell.Skill == 'Enhancing Magic' then
		--Sneak Gear
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		--Invisible Gear
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible)
		--Standard Enfeebling
		else
			gFunc.EquipSet(sets.Enhancing)
        end
		
	--Healing Magic Spells
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure)
    
    --Spell Interupt / Haste Default Set	
	else
		gFunc.EquipSet(sets.SIRD)
    end
	
end

--Weaponskill Function
profile.HandleWeaponskill = function()

    local ws = gData.GetAction()
    
    gFunc.EquipSet(sets.WS)
	
end

--Checks for Obi Applicability. Accounts for negative weather/day associations. Obi must hit 10% to pass requirement to equip. 
function ObiCheck(spell)
	local element = spell.Element
	local zone = gData.GetEnvironment()
	local badEle = {
		['Fire'] = 'Water',
		['Earth'] = 'Wind',
		['Water'] = 'Thunder',
		['Wind'] = 'Ice',
		['Ice'] = 'Fire',
		['Thunder'] = 'Earth',
		['Light'] = 'Dark',
		['Dark'] = 'Light'
	};
	
	if element == 'Thunder' then
		element = 'Lightning'
	end
	
	local bad_element = badEle[spell.Element]
	if bad_element == 'Thunder' then
		bad_element = 'Lightning'
	end	
	
	local weight = 0
	
	--Day comparison
	if string.find(zone.Day, element) then
		weight = weight + 1
	elseif string.find(zone.Day, bad_element) then
		weight = weight - 1
	end
	
	--Weather comparison
	if string.find(zone.Weather, spell.Element) then
		if string.find(zone.Weather, 'x2') then
			weight = weight + 2.5
		else
			weight = weight + 1
		end
	elseif string.find(zone.Weather, badEle[spell.Element]) then
		if string.find(zone.Weather, 'x2') then
			weight = weight - 2.5
		else
			weight = weight - 1
		end
	end	
	
	return weight

end

--Checks for Sorc Ring latent.
function RingActive()
	local player = gData.GetPlayer()
	
	if player.HPP <= 75 and player.TP <= 1000 then
		return true
	end
	
	return false
	
end

--Checks for Uggy Pendant latent.
function UggyPendant(spell)
	local player = gData.GetPlayer()
	
	if spell.MppAftercast <= 50 then
		return true
	end
	
	return false
	
end

return profile;

--[[

	Sets with _Priority are prepped for HorizonXI level sync and use . 
	
	Put gear into the sets in order and you will automatically downshift gear when you sync. This helps keep you from constantly swapping or rewriting sets.
	
	Ex: 
		Resting_Priority = {
			Main = {'Dark Staff','Pilgrim\'s Wand',},
			Neck = 'Checkered Scarf',
			Body = {'Errant Hpl.','Seer\'s Tunic',},
			Legs = 'Baron\'s Slops',
		},
		
	The above will equip Dark Staff while resting if at or above level 51, and Pilgrim's Wand if you are level 50 to 10. Same idea behind Errant body where it will only be on at 72 or above. 
		
	To use the set call it in a later function like normal but without the "_Priority" desegnator. 
	
	Ex:		
		elseif (player.Status == 'Resting') then
			gFunc.EquipSet(sets.Resting)
	
	Any pieces that are not within {} brackets will swap like normal. It is not required for all sets to have a _Priority tag. Order of pieces in the set should not matter, but I can't say I've personally tested that as mine are in descending level order to keep my thoughts organized. 

]]