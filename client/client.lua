local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srr = {}
Tunnel.bindInterface("srr_selldrugs", srr)
vSERVER = Tunnel.getInterface("srr_selldrugs")

local fixedPeds = {}

CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(Config.SellDrugs) do
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z))
            if distance <= 30 then
                if not fixedPeds[k] then
                    RequestModel(v.hashped)
                    while not HasModelLoaded(v.hashped) do
                        Wait(1)
                    end
                    ped = CreatePed(4,v.hashped,v.x,v.y,v.z-1,v.h,false,false)
                    FreezeEntityPosition(ped,true)
                    SetEntityInvincible(ped,true)
                    SetBlockingOfNonTemporaryEvents(ped,true)
                    fixedPeds[k] = ped
                else
                    if distance <= 4 then
                        sleep = 4
                        DrawText3D(v.x,v.y,v.z,"Pressione [~r~E~w~] Comprar Drogas")
                        if IsControlJustPressed(0,38) then
                            vSERVER.sellDrugs(k,v)
                        end
                    end
                end
            else 
                if fixedPeds[k] then
                    DeletePed(ped)
                    fixedPeds[k] = false
                end
            end
        end
        Wait(sleep)
    end
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end
