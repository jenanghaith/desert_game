extends Node

var flags_raised = 0

func raise_flag(flag_node):
	flags_raised += 1
	print("Flag raised! Total:", flags_raised)
