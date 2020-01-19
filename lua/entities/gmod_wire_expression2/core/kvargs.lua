registerType("kvarg", "xkv", {},
	nil,
	nil,
	function(retval)
        if not istable(retval) then error("Return value is not a table", 0) end
        if retval.__type ~= "kvarg" then error("Return value is not a kvarg", 0) end
	end,
	function(v)
		return not istable(v) or v.__type ~= "kvarg"
	end
)

__e2setcost(2)

registerOperator("kvarg", "", "xkv", function(self, args)
    local tab = {{}, {}, {}}

    local counter = 0
    
    local kvargs = args[2]
    for i = 1, #kvargs[4] do
        if kvargs[1][i] == nil then
            counter = counter + 1

            tab[1][counter] = kvargs[2][i][1](self, kvargs[2][i])
            tab[2][counter] = 'n'
            tab[3][counter] = kvargs[4][i]
        else
            local key = kvargs[1][i][1](self, kvargs[1][i])

            tab[1][key] = kvargs[2][i][1](self, kvargs[2][i])
            tab[2][key] = kvargs[3][i]
            tab[3][key] = kvargs[4][i]
        end
    end

    return tab
end)