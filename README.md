This is a simple plugin
You can give all players item or weapon or money with command

also you can setting auto give time in config to all players

*Resource is edited by hristiyan_raykov#0 (Discord)*

**In Game & Console Commands:**
```
/giveallitem <item> <count>
/giveallweapon <weapon> <amount>
/addallmoney <account> <amount>
```


**Config:**
```yaml
Config = {}

Config.Locale = GetConvar('esx:locale', 'en') -- en, tw

Config.EnableServerCommand = true -- you can using command on console to give. but command prefix need changed to "_", example: _giveallitem, _giveallweapon, _addallmoney

-- how many minutes to give. if don't want, you can type false
Config.TimeGiveItem = false
Config.TimeGiveMoney = false
Config.TimeGiveWeapon = false
-- do you want random the auto give stuff of one?
Config.RandomGiveItem = false
Config.RandomGiveMoney = false
Config.RandomGiveWeapon = false

Config.Items = {
	{name = 'water', count = 1},
}

Config.Money = {
	{account = 'bank', amount = 500},
 	{account = 'money', amount = 500},
--	{account = 'black_money', amount = 100}
}

Config.Weapon = {
	{weaponName = 'WEAPON_PISTOL', amount = 10}, -- amount is ammo count
}
```

https://forum.cfx.re/t/release-esx-give-all-players-item-or-money/1027386
