fx_version 'bodacious'
game 'gta5'

name 'soundPoints'

author 'Gamingpions'

  
client_scripts {
  '@NativeUI/NativeUI.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'client/client.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'server/server.lua',
}

dependencies {
	'es_extended'
}
