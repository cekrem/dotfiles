# Defined in /var/folders/3d/j8rkvlgx1h58pxqfb3gyv0km0000gn/T//fish.kF2jIb/cls.fish @ line 2
function cls --description 'List contents of directory'
	command colorls --sort-dirs --report (string replace -- h '' $argv)
end
