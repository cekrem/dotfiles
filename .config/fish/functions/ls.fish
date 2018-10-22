# Defined in - @ line 2
function ls --description 'List contents of directory'
	command colorls --sort-dirs --report (string replace -- h '' $argv)
end
