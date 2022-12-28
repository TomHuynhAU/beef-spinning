Citizen.CreateThread(function()
	for k, v in pairs(Config["gachapon"]) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			TriggerClientEvent('esx_homquay:openGacha', source,k)
		end)
	end
end)

ESX.RegisterServerCallback('esx_homquay:getResult', function(source, cb, data)
	local draw = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(data).count >= 1 then
		xPlayer.removeInventoryItem(data, 1)
		local sum = 0
		for k, v in pairs(Config["gachapon"][data].list) do
			local rate = Config["chance"][v.tier].rate * 120
			for i=1,rate do
				if v.dtype == "item" then
					if v.amount then
						table.insert(draw, {item = v.item ,amount = v.amount,label = v.label, dtype = v.dtype})
					else
						table.insert(draw, {item = v.item ,amount = 1, label = v.label, dtype = v.dtype})
					end
				elseif v.dtype == "weapon" then
					table.insert(draw, {item = v.item ,label = v.label, dtype = v.dtype})
				elseif v.dtype == "money" then
					table.insert(draw, {item = v.item, label = v.label, dtype = v.dtype, amount = v.amount})
				elseif v.dtype == "skin" then
					table.insert(draw, {item = v.item, label = v.label, weapon = v.weapon, dtype = v.dtype})
				end
				i = i + 1
			end
			sum = sum + rate
		end
		local random = math.random(1, sum)
		cb({
			item = draw[random],
			remaining = xPlayer.getInventoryItem(data).count
		})
		Wait(14500)
		if draw[random].dtype == "item" then
			xPlayer.addInventoryItem(draw[random].item, draw[random].amount)
			sendToDiscord('Hòm quay', GetPlayerName(source)..' quay ra: '..draw[random].item..' số lượng '..draw[random].amount, 8421504)
		elseif draw[random].dtype == "weapon" then
			xPlayer.addWeapon(draw[random].item, 1)
			sendToDiscord('Hòm quay', GetPlayerName(source)..' quay ra: '..draw[random].item..' súng', 8421504)
		elseif draw[random].dtype == "money" then
			xPlayer.addMoney(draw[random].amount)
			sendToDiscord('Hòm quay', GetPlayerName(source)..' quay ra: '..draw[random].amount..' tiền mặt', 8421504)
		elseif draw[random].dtype == "skin" then
			sendToDiscord('Hòm quay', GetPlayerName(source)..' quay ra: '..draw[random].weapon..' skin súng', 8421504)
		end
	else
		cb(false)
	end
end)

-- ESX.RegisterCommand('testhomquay1', 'admin', function(xPlayer, args, showError)
--     for i=1,50 do 
--         local draw = {}
-- 		local sum = 0
-- 		for k, v in pairs(Config["gachapon"]["gacha_02"].list) do
-- 			local rate = Config["chance"][v.tier].rate * 120
-- 			for i=1,rate do
-- 				if v.dtype == "item" then
-- 					if v.amount then
-- 						table.insert(draw, {item = v.item ,amount = v.amount,label = v.label, dtype = v.dtype})
-- 					else
-- 						table.insert(draw, {item = v.item ,amount = 1, label = v.label, dtype = v.dtype})
-- 					end
-- 				elseif v.dtype == "weapon" then
-- 					table.insert(draw, {item = v.item ,label = v.label, dtype = v.dtype})
-- 				elseif v.dtype == "money" then
-- 					table.insert(draw, {item = v.item, label = v.label, dtype = v.dtype, amount = v.amount})
-- 				elseif v.dtype == "skin" then
-- 					table.insert(draw, {item = v.item, label = v.label, weapon = v.weapon, dtype = v.dtype})
-- 				end
-- 				i = i + 1
-- 			end
-- 			sum = sum + rate
-- 		end
-- 		local random = math.random(1, sum)
-- 		if draw[random].dtype == "weapon" then
-- 		    print(draw[random].label)
-- 	    end
-- 	end
-- end, true, {help = 'testhom', validate = true, arguments = {
-- }})

-- ESX.RegisterCommand('testhomquay2', 'admin', function(xPlayer, args, showError)
--     for i=1,50 do 
--         local draw = {}
-- 		local sum = 0
-- 		for k, v in pairs(Config["gachapon"]["gacha_03"].list) do
-- 			local rate = Config["chance"][v.tier].rate * 120
-- 			for i=1,rate do
-- 				if v.dtype == "item" then
-- 					if v.amount then
-- 						table.insert(draw, {item = v.item ,amount = v.amount,label = v.label, dtype = v.dtype})
-- 					else
-- 						table.insert(draw, {item = v.item ,amount = 1, label = v.label, dtype = v.dtype})
-- 					end
-- 				elseif v.dtype == "weapon" then
-- 					table.insert(draw, {item = v.item ,label = v.label, dtype = v.dtype})
-- 				elseif v.dtype == "money" then
-- 					table.insert(draw, {item = v.item, label = v.label, dtype = v.dtype, amount = v.amount})
-- 				elseif v.dtype == "skin" then
-- 					table.insert(draw, {item = v.item, label = v.label, weapon = v.weapon, dtype = v.dtype})
-- 				end
-- 				i = i + 1
-- 			end
-- 			sum = sum + rate
-- 		end
-- 		local random = math.random(1, sum)
-- 		if draw[random].dtype == "weapon" then
-- 		    print(draw[random].label)
-- 	    end
-- 	end
-- end, true, {help = 'testhom2', validate = true, arguments = {
-- }})

-- ESX.RegisterCommand('givehomquay', 'admin', function(xPlayer, args, showError)
--     local xPlayers = ESX.GetPlayers()
--     for i=1, #xPlayers, 1 do
--         local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
--         xPlayer.addInventoryItem("gacha_01", 1)
--     end
-- end, true, {help = 'Cho tất cả người chơi hòm quay', validate = true, arguments = {
-- }})

-- ESX.RegisterCommand('givehomquay2', 'admin', function(xPlayer, args, showError)
--     local xPlayers = ESX.GetPlayers()
--     for i=1, #xPlayers, 1 do
--         local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
--         xPlayer.addInventoryItem("gacha_02", 1)
--     end
-- end, true, {help = 'Cho tất cả người chơi hòm quay', validate = true, arguments = {
-- }})

function sendToDiscord(name,message,color)
	local DiscordWebHook = "https://discord.com/api/webhooks/891386358818553946/ITiiR3ERp5HUVBBSxY4HKtSAaip_LwoMXq-4v83QKCo0JOG80KhxsirsMkt7pN3DaKL7"
	local embeds = {
	        {
	            ["title"]=message,
	            ["type"]="rich",
	            ["color"] =color,
	            ["footer"]=  {
	                ["text"]= "Diamond",
	            },
	        }
	    }
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
