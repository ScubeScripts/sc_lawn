ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('lawnmower:getPlayerJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.job)
    else
        cb(nil)
    end
end)

RegisterServerEvent('lawnmower:completeTask')
AddEventHandler('lawnmower:completeTask', function(payment)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        xPlayer.addMoney(payment)
    end
end)