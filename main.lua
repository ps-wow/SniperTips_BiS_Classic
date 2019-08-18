local SniperTips_BiS_Classic = LibStub("AceAddon-3.0"):NewAddon('SniperTips_BiS_Classic');
local LibTooltip = LibStub("SniperTips-2.0");
local tipColour = { 0.6, 0.2, 0.2 }

SniperTips_BiS_Classic.kbDEBUG = true

SniperTips_BiS_Classic.Globals = {
  ["TitleColour"] = {
    ["escape"] = "|cFFABD473",
    ["rgb"] = { 0.67, 0.83, 0.45 },
    ["rgba"] = { 0.67, 0.83, 0.45, 1 },
  },
  -- 170, 141, 114
  ["Ratings"] = {
    ["NA"] = { 
      ["escape"] = "|cFF9D9D9D",
      ["rgba"] = { 0.62, 0.62, 0.62, 1 }
    },
    ["Bad"] = { 
      ["escape"] = "|cFFFFFFFF",
      ["rgba"] = { 1.00, 1.00, 1.00, 1 }
    },
    ["Good"] = { 
      ["escape"] = "|cFF00A7DD",
      ["rgba"] = { 0.00, 0.44, 0.87, 1 }
    },
    ["Epic"] = {
      ["escape"] = "|cFFA335EE",
      ["rgba"] = { 0.64, 0.21, 0.93, 1 }
    }
  },
  ["NA"] = "N/A",
  ["Bad"] = "Bad",
  ["Good"] = "Good",
  ["Epic"] = "Epic",
}

function SniperTips_BiS_Classic:Dump(str, obj)
  if ViragDevTool_AddData and SniperTips_BiS_Classic.kbDEBUG then
      ViragDevTool_AddData(obj, str)
  end
end

-- Combine the above two checks into a single function.
function SniperTips_BiS_Classic:AddonShouldLoad()
  return true
end

----------------
-- Core Logic --
----------------
function SniperTips_BiS_Classic:ItemIsEquipment(itemClassID, itemSubClassID, itemId)
  -- we may have to add overrides above if anything eatable is not of this type,
  -- although I doubt that will be the case?

  -- 0: Consumables, 5: Food & Drink
  if (itemClassID == 0 and itemSubClassID == 5) then
    return true
  -- 7: Tradeskill, 8: Cooking
  elseif (itemClassID == 7 and itemSubClassID == 8) then
    return true
  end

  return false
end

function SniperTips_BiS_Classic:GetCurrentPhase()
  return 1
end

function SniperTips_BiS_Classic:HandleItem(self, item)
  -- Only load for the consumables item category
  if (SniperTips_BiS_Classic:ItemIsEquipment(item.classID, item.subClassID, item.id) == false) then
    return -- void
  end

  local rating, ratingColour = SniperTips_BiS_Classic:GetItemBiS(item.id)

  if (rating ~= nil and ratingColour ~= nil) then
    self:AddDoubleLine(
      SniperTips_BiS_Classic.Globals.TitleColour.escape.."Food Rating: ",
      ratingColour..rating
    );
  end
end

---------------
-- BiS Logic --
---------------

function SniperTips_BiS_Classic:GetItemBiS(itemId)
  return nil, nil
end

-----------------
-- Registration --
------------------

if (SniperTips_BiS_Classic:AddonShouldLoad()) then
  LibTooltip:AddItemHandler(SniperTips_BiS_Classic)
end
