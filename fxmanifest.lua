fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'vanishdev'
description 'A simple looking hud, UI was inspired from another resource, many features included.'

shared_script '@ox_lib/init.lua'
client_scripts { 'client/*.lua' }

ui_page 'web/index.html'
files { 'web/**', 'data/*.lua' }

dependency 'ox_lib'