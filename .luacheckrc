std = "lua51"
max_line_length = false
codes = true
exclude_files = {
	"**/libs",
}
ignore = {
	"11/SLASH_.*", -- slash handlers
	"11/BINDING_.*", -- keybinds
	"1/[A-Z][A-Z][A-Z0-9_]+", -- three letter+ constants
	"211", -- Unused local variable
	"212", -- Unused argument
	"213", -- Unused loop variable
	"432/self", -- Shadowing an upvalue argument
}
globals = {
    -- addon
    "PortableGreatVault",

	-- wow std api
	"abs",
	"acos",
	"asin",
	"atan",
	"atan2",
	"bit",
	"ceil",
	"cos",
	"date",
	"debuglocals",
	"debugprofilestart",
	"debugprofilestop",
	"debugstack",
	"deg",
	"difftime",
	"exp",
	"fastrandom",
	"floor",
	"forceinsecure",
	"foreach",
	"foreachi",
	"format",
	"frexp",
	"geterrorhandler",
	"getn",
	"gmatch",
	"gsub",
	"hooksecurefunc",
	"issecure",
	"issecurevariable",
	"ldexp",
	"log",
	"log10",
	"max",
	"min",
	"mod",
	"rad",
	"random",
	"scrub",
	"securecall",
	"seterrorhandler",
	"sin",
	"sort",
	"sqrt",
	"strbyte",
	"strchar",
	"strcmputf8i",
	"strconcat",
	"strfind",
	"string.join",
	"strjoin",
	"strlen",
	"strlenutf8",
	"strlower",
	"strmatch",
	"strrep",
	"strrev",
	"strsplit",
	"strsub",
	"strtrim",
	"strupper",
	"table.wipe",
	"tan",
	"time",
	"tinsert",
	"tremove",
	"wipe",

	-- everything else
	"C_WeeklyRewards",
	"DifficultyUtil",
	"Enum",
	"PVPUtil",
	"WeeklyRewardsFrame",
}
