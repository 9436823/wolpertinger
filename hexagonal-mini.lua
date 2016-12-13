return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.0",
  orientation = "hexagonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 14,
  tileheight = 12,
  nextobjectid = 2,
  hexsidelength = 6,
  staggeraxis = "y",
  staggerindex = "odd",
  properties = {},
  tilesets = {
    {
      name = "hex mini",
      firstgid = 1,
      tilewidth = 18,
      tileheight = 18,
      spacing = 0,
      margin = 0,
      image = "hexmini.png",
      imagewidth = 106,
      imageheight = 72,
      tileoffset = {
        x = 0,
        y = 1
      },
      properties = {},
      terrains = {},
      tilecount = 20,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Ground",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 6, 11, 0, 3, 0, 0, 3, 3, 0, 0,
        0, 0, 0, 0, 0, 3, 3, 3, 3, 6, 14, 11, 11, 3, 11, 11, 11, 3, 3, 0,
        0, 0, 6, 6, 6, 6, 3, 3, 3, 6, 14, 14, 3, 11, 11, 3, 3, 11, 3, 0,
        6, 6, 6, 15, 5, 6, 3, 3, 6, 14, 14, 14, 3, 3, 3, 3, 3, 11, 3, 0,
        0, 5, 2, 14, 14, 7, 6, 6, 6, 14, 13, 5, 5, 3, 3, 3, 3, 3, 11, 11,
        10, 10, 2, 2, 14, 12, 6, 6, 14, 10, 13, 5, 2, 2, 3, 3, 3, 3, 3, 11,
        5, 10, 10, 13, 14, 14, 14, 14, 14, 10, 13, 5, 2, 2, 2, 2, 3, 3, 3, 3,
        5, 13, 13, 14, 14, 14, 14, 2, 2, 10, 5, 5, 11, 2, 2, 2, 3, 3, 3, 0,
        5, 5, 5, 14, 14, 14, 14, 2, 2, 2, 5, 2, 11, 11, 2, 2, 2, 2, 10, 0,
        14, 14, 14, 14, 14, 14, 5, 2, 2, 2, 2, 11, 11, 11, 2, 2, 2, 10, 9, 0,
        14, 14, 14, 14, 14, 14, 13, 5, 2, 2, 2, 11, 11, 11, 2, 2, 2, 10, 10, 0,
        14, 14, 13, 13, 14, 14, 13, 5, 2, 2, 2, 2, 11, 2, 2, 12, 13, 10, 0, 0,
        0, 14, 13, 13, 14, 14, 13, 5, 2, 2, 2, 2, 2, 2, 2, 7, 7, 13, 13, 0,
        14, 13, 13, 13, 14, 13, 5, 2, 2, 2, 2, 2, 2, 7, 7, 7, 13, 0, 0, 0,
        0, 10, 13, 13, 14, 14, 5, 2, 2, 2, 2, 2, 2, 2, 7, 7, 0, 0, 0, 0,
        10, 10, 13, 13, 14, 14, 5, 2, 2, 2, 2, 4, 2, 2, 2, 0, 0, 0, 0, 0,
        10, 10, 10, 10, 13, 14, 2, 2, 2, 2, 4, 4, 2, 7, 7, 0, 0, 0, 0, 0,
        10, 10, 10, 14, 14, 14, 5, 5, 2, 4, 4, 2, 12, 7, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Kachelebene 2",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = -7,
      properties = {},
      encoding = "lua",
      data = {
        17, 17, 17, 17, 17, 17, 17, 17, 17, 3, 3, 13, 13, 13, 13, 13, 13, 13, 13, 13,
        17, 17, 17, 17, 17, 17, 17, 17, 3, 3, 0, 13, 13, 13, 13, 13, 13, 13, 13, 13,
        3, 17, 17, 3, 3, 3, 17, 17, 17, 3, 0, 0, 0, 13, 13, 0, 0, 3, 13, 13,
        3, 3, 3, 3, 0, 3, 17, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3, 13, 13,
        0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 13,
        0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "Objektebene 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    }
  }
}