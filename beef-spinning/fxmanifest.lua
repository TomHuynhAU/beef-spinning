fx_version 'adamant'
game 'gta5'

ui_page "html/index.html"

shared_script '@es_extended/imports.lua'

client_scripts {
	'client.lua',
	'config.lua'
}
server_scripts {
	'server.lua',
	'config.lua'
}
files {
    "html/index.html",
    "html/index.css",
    "html/script.js",
    "html/mohom.mp3",
    "html/win.mp3",
	"html/img/*.png"
}
--
--