Dictionary_ltex = {}

for word in io.open("/home/sixten/.config/nvim/spell/en.utf-8.add", "r"):lines() do
	table.insert(Dictionary_ltex, word)
end
