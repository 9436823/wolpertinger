package.path = package.path .. ";source/?.lua"
local composer = require( "composer" )
--require("tests")
composer.gotoScene( "scene1" )
