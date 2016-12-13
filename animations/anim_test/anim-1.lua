--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c2b10bf9f2ce9daee70bc3be3adaec50:e90f338fb59b804cbe671148eae627d2:dd81f3556de9b29fd609890cad4581ce$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- anim-10000
            x=1,
            y=1,
            width=100,
            height=100,

        },
        {
            -- anim-10001
            x=103,
            y=1,
            width=100,
            height=100,

        },
        {
            -- anim-10002
            x=205,
            y=1,
            width=100,
            height=100,

        },
        {
            -- anim-10003
            x=307,
            y=1,
            width=100,
            height=100,

        },
        {
            -- anim-10004
            x=409,
            y=1,
            width=100,
            height=100,

        },
    },
    
    sheetContentWidth = 510,
    sheetContentHeight = 102
}

SheetInfo.frameIndex =
{

    ["anim-10000"] = 1,
    ["anim-10001"] = 2,
    ["anim-10002"] = 3,
    ["anim-10003"] = 4,
    ["anim-10004"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
