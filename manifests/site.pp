import 'nodes/*.pp'

File {
	mode   => '0644',
	owner  => 'root',
	group  => 'root',
	ignore => ['.svn', '.git', 'CVS'],
}

node default {
	fail('No node definition found for ${fqdn}.')
}
