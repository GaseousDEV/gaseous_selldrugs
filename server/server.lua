local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

srr = {}
Tunnel.bindInterface("srr_selldrugs", srr)
vCLIENT = Tunnel.getInterface("srr_selldrugs")

function srr.sellDrugs(k,v)
    local source = source
    local user_id = vRP.getUserId(source)

    local chest = vRP.getSData('chest:'..k)
    local balance = json.decode(chest) or {}
    local citem = balance[Config.SellDrugs[k]["item"]]
    
    if not citem then TriggerClientEvent("Notify",source,"negado","Sem Estoque") return end
    
    local camount = citem.amount

    TriggerClientEvent("Notify",source,"sucesso","Quantidade de " ..vRP.itemNameList(Config.SellDrugs[k]["item"]).. " no Estoque: " ..camount)

    local amount = vRP.prompt(source, "Quantidade De Drogas", "")
    amount = tonumber(parseInt(amount))

    if not amount then return end
    
    if amount < 0 then amount = 1 end
    
    if user_id then
        if CheckDrugs(amount,k,v) then
            local price = parseInt(v.value)
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(Config.SellDrugs[k]["item"])*amount <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.tryPayment(user_id, amount * price) then -- PARA COLOCAR PARA PUXAR O DINHEIRO DO BANCO TBM SO MUDAR DE "tryPayment" PARA "tryFullPayment"
                    balance[Config.SellDrugs[k]["item"]].amount = parseInt(balance[Config.SellDrugs[k]["item"]].amount) - parseInt(amount)
                    vRP.setSData("chest:"..tostring(k),json.encode(balance))
                    DepositMoney(k,v,amount * price)
                    vRP.giveInventoryItem(user_id,"maconha",amount)
                else 
                    TriggerClientEvent("Notify",source,"negado","Dinheiro Insuficiente")
                end
            else
                TriggerClientEvent("Notify",source,"negado","Mochila Cheia")
            end
        end
    end
end

function CheckDrugs(amount,k,v)
    local value = vRP.getSData('chest:'..k)
    local balance = json.decode(value) or {}
    local camount = balance[Config.SellDrugs[k]["item"]].amount
    if camount >= amount then
        return true
    else 
        TriggerClientEvent("Notify",source,"sucesso","Quantidade Invalida")
        return false
    end
end

function DepositMoney(k,v,payment) 
    local value = vRP.getSData('Bank:'..k)
    local balance = json.decode(value) or 0
    vRP.setSData('Bank:'..k,balance+payment)
end

function CheckBank(amount,k)
    local value = vRP.getSData('Bank:'..k)
    value = tonumber(value)
    if amount <= value then
        return true
    else 
        TriggerClientEvent("Notify",source,"sucesso","Valor Invalido")
        return false
    end
end

RegisterCommand("sacarfac", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then 
        
        local amount = vRP.prompt(source, "Valor a ser Sacado", "")
        
        amount = tonumber(parseInt(amount))
        
        if not amount then return end

        if amount < 0 then amount = 1 end
        
        for k,v in pairs(Config.SellDrugs) do

            if not vRP.hasPermission(user_id,v.permission) return then end

            local balance = vRP.getSData('Bank:'..k)
            local distance = #(GetEntityCoords(GetPlayerPed(source)) - vector3(v.x2,v.y2,v.z2))
            if CheckBank(amount,k) then
                if distance <= 3 then
                    amount = tonumber(amount)
                    vRP.setSData('Bank:'..k,balance-amount)
                    vRP.giveMoney(user_id,amount)
                end
            end
        end
    end
end)

RegisterCommand("saldofac", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local message = "Facs Disponiveis: "
    if user_id then 

        for k,v in pairs(Config.SellDrugs) do

            message = message.. k..", "

            if not vRP.hasPermission(user_id,v.permission) return then end

            local balance = vRP.getSData('Bank:'..k) or 0 -
            TriggerClientEvent("Notify",source,"sucesso","Saldo Da Sua Fac é " ..balance)
        end
        
        if vRP.hasPermission(user_id,Config.PermAdmin) then
            if Config.SellDrugs[args[1]] then
                local balance = vRP.getSData('Bank:'..k) or 0 
                TriggerClientEvent("Notify",source,"sucesso","Saldo Da Fac: " ..Config.SellDrugs[args[1]].. " é " ..balance)
            else
                TriggerClientEvent("Notify", source, "aviso",message)
            end
        end

    end
end)
