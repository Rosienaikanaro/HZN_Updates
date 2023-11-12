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
}

local gorgets = {

	Soil = T{--'Asuran Fists'
		};

	Breeze = T{'Dragon Kick', 'Raging Fists'
		};

};

local sets = {
    Idle_Priority = {
        Ammo = 'Happy Egg',
        Head = {'Melee Crown','Emperor Hairpin',},
		Neck = {'Evasion Torque','Peacock Amulet','Spike Necklace','Wind Pendant',},
        Ear1 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Body = {'Melee Cyclas','Scorpion Harness','Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
        Hands = {'Melee Gloves','Temple Gloves','Wonder Mitts','Battle Gloves',},
        Ring1 = {'Merman\'s Ring','Rajas Ring','Balance Ring',},
        Ring2 = {'Merman\'s Ring','Toreador\'s Ring','Victory Ring','Deft Ring','Balance Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Black Belt','Swift Belt','Purple Belt',},
        Legs = {'Melee Hose','Temple Hose','Cmb.Cst. Slacks','Wonder Braccae','Republic Subligar','Bone Subligar +1',},
        Feet = {'Melee Gaiters','Temple Gaiters','Wonder Clomps','Leaping Boots',},
    },
	
	Resting = {
	
	},
		
	TP_Priority = {
        Ammo = 'Tiphia Sting',
        Head = {'Panther Mask','Voyager Sallet','Emperor Hairpin','Bone Mask +1',},
		Neck = {'Peacock Amulet','Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Body = {'Shura Togi','Scorpion Harness','Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
        Hands = {'Melee Gloves','Battle Gloves',},
		Ring1 = {'Rajas Ring','Balance Ring',},  
		Ring2 = {'Toreador\'s Ring','Jaeger Ring','Balance Ring',},		
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Black Belt','Swift Belt','Purple Belt',},
        Legs = {'Byakko\'s Haidate','Melee Hose','Cmb.Cst. Slacks','Republic Subligar','Bone Subligar +1',},
        Feet = {'Sarutobi Kyahan','Wonder Clomps',},
    },
	
	Accuracy_Priority = {
        Ammo = 'Tiphia Sting',
        Head = {'Panther Mask','Voyager Sallet','Emperor Hairpin','Bone Mask +1',},
		Neck = {'Peacock Amulet','Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Body = {'Shura Togi','Scorpion Harness','Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
        Hands = {'Noritsune Kote','Battle Gloves',},
		Ring1 = {'Rajas Ring','Balance Ring',},  
		Ring2 = {'Toreador\'s Ring','Jaeger Ring','Balance Ring',},		
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Black Belt','Swift Belt','Purple Belt',},
        Legs = {'Byakko\'s Haidate','Melee Hose','Cmb.Cst. Slacks','Republic Subligar','Bone Subligar +1',},
        Feet = {'Sarutobi Kyahan','Wonder Clomps',},
    },
	
	Hundo = {
        Ammo = 'Tiphia Sting',
        Head = 'Shr.Znr.Kabuto',
		Neck = 'Peacock Amulet',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Hands = 'Melee Gloves',
		Ring1 = 'Rajas Ring',  
		Ring2 = 'Toreador\'s Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Life Belt',
        Legs = 'Melee Hose',
        Feet = 'Dune Boots',
    },
	
	SE_Hundo = {
		Ammo = 'Happy Egg',		
	},
	
	WS_Priority = {
		Ammo = '',
        Head = {'Shr.Znr.Kabuto','Voyager Sallet','Emperor Hairpin','Bone Mask +1',},
		Neck = {'Spike Necklace',},
        Ear1 = {'Brutal Earring','Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Ear2 = {'Merman\'s Earring','Spike Earring','Beetle Earring +1','Bone Earring +1',},
        Body = {'Kirin\'s Osode','Scorpion Harness','Jujitsu Gi','Wonder Kaftan','Mrc.Cpt. Doublet','Beetle Harness +1','Bone Harness +1',},
		Hands = {'Melee Gloves','Temple Gloves','Wonder Mitts','Battle Gloves',},
        Ring1 = {'Rajas Ring','Courage Ring',},
        Ring2 = {'Triumph Ring','Victory Ring','Courage Ring',},
        Back = {'Amemet Mantle +1','Traveler\'s Mantle',},
        Waist = {'Black Belt','Life Belt','Purple Belt',},
        Legs = {'Shura Haidate','Cmb.Cst. Slacks','Republic Subligar','Bone Subligar +1',},
        Feet = {'Creek M Clomps','Wonder Clomps','Leaping Boots',},
	},
	
	Focus = {
		Head = 'Temple Crown',
	},
	
	Chakra = {
		Ammo = 'Happy Egg',
		Head = 'Genbu\'s Kabuto',
		Body = 'Temple Cyclas',
		Hands = 'Melee Gloves',
		Back = 'Melee Cape',
		Feet = 'Creek M Clomps',
	},
	
	Boost = {
		Hands = 'Temple Gloves',
	},
	
	Dodge = {
		Feet = 'Temple Gaiters',
	},
	
	Counterstance = {
		Feet = 'Melee Gaiters',
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
	gSettings.AllowAddSet = true
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /mnk /lac fwd')
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /mnk /lac fwd')
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
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	
	
    if player.Status == 'Engaged' then
		if gData.GetBuffCount("Hundred Fists") >= 1 then
			gFunc.EquipSet(sets.Hundo)
		elseif Settings.AccToggle then
			gFunc.EquipSet(sets.Accuracy)
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

    if (ability.Name == 'Focus') then
        gFunc.EquipSet(sets.Focus);
	elseif (ability.Name == 'Chakra') then
        gFunc.EquipSet(sets.Chakra);
	elseif (ability.Name == 'Boost') then
        gFunc.EquipSet(sets.Boost);
	elseif (ability.Name == 'Dodge') then
        gFunc.EquipSet(sets.Dodge);
	elseif (ability.Name == 'Counterstance') then
        gFunc.EquipSet(sets.Counterstance);
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
	
	if (gorgets.Soil:contains(ws.Name)) then
		gFunc.Equip('neck','Soil Gorget')
	elseif gorgets.Breeze:contains(ws.Name) then
		gFunc.Equip('neck','Breeze Gorget')
	end
	
end

return profile;