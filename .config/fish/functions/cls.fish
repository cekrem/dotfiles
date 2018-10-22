# Defined in - @ line 2
function cls
	colorls --sort-dirs --report (string replace -- h '' $argv)
end
