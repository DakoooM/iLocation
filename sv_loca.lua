ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("DakoM:PaymentLocation", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
         if xPlayer.getMoney() >= price then
              cb(true)
              xPlayer.removeMoney(price)
         else
              cb(false)
         end
    end
end)
