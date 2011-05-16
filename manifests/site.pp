import 'nodes/*.pp'

File {
	ignore => ['.svn', '.git', 'CVS']
}

node default {
	notice('No node definition found for ${fqdn}.')
}
