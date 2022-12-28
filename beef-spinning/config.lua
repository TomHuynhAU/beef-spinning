Config = {}

Config["image_source"] = "nui://ox_inventory/web/images/"

Config.CloseInventoryHudTrigger = "ox_inventory:closeInventory"

Config["chance"] = {
	[1] = { rate = 35 },
	[2] = { rate = 33 },
	[3] = { rate = 22 },
	[4] = { rate = 5} ,
	[5] = { rate = 3 },
	[6] = { rate = 2 },
}

Config["gachapon"] = {
	["hommayman"] = {
		name = "Hòm Súng",
		list = {
			{ label = "burger",       	     item    = "burger",     tier = 6, dtype = "item", special = 1 },
			{ label = "burger",  			item 	 = "burger",     tier = 5, dtype = "item" },
			{ label = "burger",        		item    = "burger",     tier = 4, dtype = "item" },
			{ label = "burger",           	item    = "burger",        tier = 4, dtype = "item" },
			{ label = "burger",       	 	item 	 = "burger",   tier = 3, dtype = "item" },
			{ label = "burger",     		 item	 = "burger",   tier = 3, dtype = "item" },
			{ label = "water",            item    = "water",              tier = 3, dtype = "item" },
			{ label = "water",      		 item    = "water",          tier = 3, dtype = "item",  amount = 1 },
			{ label = "water",      		 item    = "water",          tier = 3, dtype = "item",  amount = 1 },
			{ label = "water",      	 item    = "water",          tier = 2, dtype = "item",  amount = 10 },
			{ label = "water",           item    = "water",                   tier = 1, dtype = "item", amount = 5 },
			{ label = "water",                item    = "water",                    tier = 1, dtype = "item",  amount = 10 },
			{ label = "water",                item    = "water",                    tier = 1, dtype = "item",  amount = 40 },
		}
	},
}
