-- !## Edited By hristiyan_raykov#0 ##! --
-- !## Edited By hristiyan_raykov#0 ##! --


-- ### Variables set ### --

ESX = exports.es_extended:getSharedObject()
xPlayers = ESX.GetPlayers()

-- ## End Exports ## --

-- ### Functions ### --
Citizen.CreateThread(function()
	if Config.TimeGiveItem ~= false then		
		SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
	elseif Config.TimeGiveMoney ~= false then
		SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)
	elseif Config.TimeGiveWeapon ~= false then
		SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)
	end	
end)

function TimeGiveItems()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if Config.RandomGiveItem then
			local ranItem = math.random(1, #Config.Items)
			xPlayer.addInventoryItem(Config.Items[ranItem].name, Config.Items[ranItem].count)	
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('item_msg', Config.Items[ranItem].count, ESX.GetItemLabel(Config.Items[ranItem].name)), 'CHAR_MP_MORS_MUTUAL', 9)			
		else
			for i=1, #Config.Items, 1 do
				xPlayer.addInventoryItem(Config.Items[i].name, Config.Items[i].count)	
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('item_msg', Config.Items[i].count, ESX.GetItemLabel(Config.Items[i].name)), 'CHAR_MP_MORS_MUTUAL', 9)
			end
		end
	end
	SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
end

function TimeGiveMoney()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	
		if Config.RandomGiveMoney then
			local ranMoney = math.random(1, #Config.Money)
			if Config.Money[ranMoney].account == 'money' then
				xPlayer.addMoney(Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('money_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif Config.Money[ranMoney].account == 'bank' then
				xPlayer.addAccountMoney(Config.Money[ranMoney].account, Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('bank_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
			elseif Config.Money[ranMoney].account == 'black_money' then
				xPlayer.addAccountMoney(Config.Money[ranMoney].account, Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('black_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
			end			
		else
			for i=1, #Config.Money, 1 do
				if Config.Money[i].account == 'money' then
					xPlayer.addMoney(Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('money_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)
				elseif Config.Money[i].account == 'bank' then
					xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('bank_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
				elseif Config.Money[i].account == 'black_money' then
					xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('black_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
				end
			end			
		end
	end
	SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)	
end

function TimeGiveWeapon()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	
		if Config.RandomGiveWeapon then
			local ranWeapon = math.random(1, #Config.Weapon)
			xPlayer.addWeapon(Config.Weapon[ranWeapon].weaponName, Config.Weapon[ranWeapon].amount)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('weapon_msg', ESX.GetWeaponLabel(Config.Weapon[ranWeapon].weaponName), Config.Weapon[ranWeapon].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
		else
			for i=1, #Config.Weapon, 1 do
				xPlayer.addWeapon(Config.Weapon[i].weaponName, Config.Weapon[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('weapon_msg', ESX.GetWeaponLabel(Config.Weapon[i].weaponName), Config.Weapon[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)			
			end					
		end
	end
	SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)	
end

-- ## End Functions ## --

-- ### Commands ### --

ESX.RegisterCommand('giveallitem', 'admin', function(xPlayer, args, showError)
	local _source = source
	local item    = args[1]
	local count   = (args[2] == nil and 1 or tonumber(args[2]))
	
	for i=1, #xPlayers, 1 do
		local _xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if ESX.GetItemLabel(item) ~= nil then
			_xPlayer.addInventoryItem(item, count)
			TriggerClientEvent('esx:showAdvancedNotification', _xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
		else
			xPlayer.showNotification(TranslateCap('unknown_item'))
		end	
	end
end, Config.EnableServerCommand or false, {help = 'give all players item', validate = true, arguments = {{name = "item", help = 'item name', type = 'string'}, {name = "amount", help = 'iteam amount', type = 'string'}}})

ESX.RegisterCommand('giveallweapon', 'admin', function(xPlayer, args, showError)
	local _source = source
	local weaponName = string.upper(args[1])
	local amount = (args[2] == nil and 1 or tonumber(args[2]))

	for i=1, #xPlayers, 1 do
		local _xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if ESX.GetWeaponLabel(weaponName) ~= nil then
			_xPlayer.addWeapon(weaponName, amount)
			TriggerClientEvent('esx:showAdvancedNotification', _xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
		else
			xPlayer.showNotification(TranslateCap('unknown_weapon'))
		end
	end
end, Config.EnableServerCommand or false, {help = 'give all players weapon', validate = true, arguments = {{name = "weapon", help = 'weapon name', type = 'string'}, {name = "ammo", help = 'ammo amount', type = 'string'}}})

ESX.RegisterCommand('addallmoney', 'admin', function(xPlayer, args, showError)
	local _source = source
	local account = args[1]
	local amount  = tonumber(args[2])

	for i=1, #xPlayers, 1 do
		local _xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if amount ~= nil then
			if account == "money" then
				_xPlayer.addMoney(amount)
				TriggerClientEvent('esx:showAdvancedNotification', _xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif account == 'bank' then
				_xPlayer.addAccountMoney(account, amount)
				TriggerClientEvent('esx:showAdvancedNotification', _xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif account == 'black_money' then
				_xPlayer.addAccountMoney(account, amount)
				TriggerClientEvent('esx:showAdvancedNotification', _xPlayer.source, TranslateCap('subject'), TranslateCap('subject2'), TranslateCap('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			else
				xPlayer.showNotification(TranslateCap('unknown_account', money, bank, black_money))
			end
		else
			xPlayer.showNotification(TranslateCap('unknown_amount'))
		end
	end
end, Config.EnableServerCommand or false, {help = 'give all players money', validate = true, arguments = {{name = "account", help = 'money account', type = 'string'}, {name = "amount", help = 'money amount', type = 'string'}}})

-- ## End Cmds ## --

-- !## Edited By hristiyan_raykov#0 ##! --
-- !## Edited By hristiyan_raykov#0 ##! --