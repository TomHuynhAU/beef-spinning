dtype = nil

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx_homquay:openGacha")
AddEventHandler("esx_homquay:openGacha", function(data)
    if Config.CloseInventoryHudTrigger ~= '' and Config.CloseInventoryHudTrigger ~= nil then
        TriggerEvent(Config.CloseInventoryHudTrigger)
    end
	dtype = data
	SetNuiFocus(true,true)
    SendNUIMessage({
        type = "ui",
        data = Config["gachapon"][data].list,
		special = Config["special"],
		remaining = GetItemAmount(data),
		name = GetPlayerName(PlayerId())
    })
end)

RegisterNUICallback('getResult', function(data, cb)
    ESX.TriggerServerCallback('esx_homquay:getResult', function(response)
		cb(response)
    end, dtype)
end)

RegisterNUICallback('esc', function(data, cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        type = "off"
    })
end)

function GetItemAmount(itemName)
    for k, v in pairs(ESX.GetPlayerData().inventory) do
        if v.name == itemName then
            return v.count
        end
    end
end

RegisterCommand("lagquayhom",function(a,b,c) 
    SetNuiFocus(false,false)
    SendNUIMessage({
        type = "off"
    })
end, false)