need_boolean('mesh_vpn.wiredigger.configurable', false)
need_one_of('mesh_vpn.wiredigger.syslog_level', {'error', 'warn', 'info', 'verbose', 'debug', 'debug2'}, false)

local function check_peer(prefix)
	return function(k, _)
		assert_uci_name(k)
		local table = string.format('%s[%q].', prefix, k)
		need_string_match(table .. 'remoteip4', '^%d+.%d+.%d+.%d+$')
		need_string(table .. 'pubkey')
		need_string_array(table .. 'endpoints')
		need_string_array(table .. 'allowedips')
	end
end



local function check_group(prefix, is_master)
	return function(k, _)
		assert_uci_name(k)

		local table = string.format('%s[%q].', prefix, k)
		if is_master then
			need_number(table .. 'keepalive')
			need_number(table .. 'cidr4')
			need_string(table .. 'regkey')
			need_string_match(table .. 'regip4', '^%d+.%d+.%d+.%d+$')
		end
		need_number(table .. 'limit', false)
		need_table(table .. 'peers', check_peer(table .. 'peers'), false)
		need_table(table .. 'groups', check_group(table .. 'groups', false), false)
		
	end
end

need_table('mesh_vpn.wiredigger.groups', check_group('mesh_vpn.wiredigger.groups', true))
