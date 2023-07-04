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
        Head = {'Emperor Hairpin',},
		Neck = {'Peacock Amulet','Spike Necklace','Wind Pendant',},
        Ear1 = {'Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Beetle Earring +1','Bone Earring +1',},
        Body = {'Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
        Hands = {'Wonder Mitts','Battle Gloves',},
        Ring1 = {'Rajas Ring','Balance Ring',},
        Ring2 = {'Deft Ring','Balance Ring',},
        Back = 'Traveler\'s Mantle',
        Waist = {'Brown Belt','Purple Belt',},
        Legs = {'Wonder Braccae','Republic Subligar','Bone Subligar +1',},
        Feet = {'Wonder Clomps','Leaping Boots',},
    },
	
	Resting = {
	
	},
		
	TP_Priority = {
        Ammo = '',
        Head = {'Voyager Sallet','Emperor Hairpin','Bone Mask +1',},
		Neck = {'Peacock Amulet','Spike Necklace',},
        Ear1 = {'Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Beetle Earring +1','Bone Earring +1',},
        Body = {'Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
        Hands = {'Battle Gloves',},
		Ring1 = {'Rajas Ring','Balance Ring',},  
		Ring2 = {'Jaeger Ring','Balance Ring',},		
        Back = {'Traveler\'s Mantle',},
        Waist = {'Brown Belt','Purple Belt',},
        Legs = {'Republic Subligar','Bone Subligar +1',},
        Feet = {'Sarutobi Kyahan','Wonder Clomps',},
    },
	
	WS_Priority = {
		Ammo = '',
        Head = {'Voyager Sallet','Emperor Hairpin','Bone Mask +1',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Beetle Earring +1','Bone Earring +1',},
        Body = {'Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
		Hands = {'Wonder Mitts','Battle Gloves',},
        Ring1 = {'Rajas Ring','Courage Ring',},
        Ring2 = {'Courage Ring',},
        Back = {'Traveler\'s Mantle',},
        Waist = {'Brown Belt','Purple Belt',},
        Legs = {'Republic Subligar','Bone Subligar +1',},
        Feet = {'Wonder Clomps','Leaping Boots',},
	},
	
    Precast = {
	
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
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
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
	elseif spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
        end
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()
	gFunc.EquipSet(sets.Shot)
end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
    
    gFunc.EquipSet(sets.WS)
	
end

return profile;