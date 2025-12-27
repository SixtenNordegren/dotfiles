-- CustomDictionary = {}
--
-- for word in io.open("$HOME/.config/nvim/spell/en.utf-8.add", "r"):lines() do
-- 	word = word:gsub("^%s*(.-)%s*$", "%1")
-- 	-- Add the word to the dictionary
-- 	table.insert(Dictionary_ltex, word)
-- end
-- Initialize the dictionary table
CustomDictionary = {}

-- Get the home directory
local home = os.getenv("HOME")
local file_path = home .. "/.config/nvim/spell/en.utf-8.add"

-- Open the file
local file = io.open(file_path, "r")

-- Check if the file was opened successfully
if file then
	for word in file:lines() do
		word = word:gsub("^%s*(.-)%s*$", "%1")
		-- Add the word to the dictionary
		table.insert(CustomDictionary, word)
	end
	file:close()
else
	print("Error: Unable to open file " .. file_path)
end
