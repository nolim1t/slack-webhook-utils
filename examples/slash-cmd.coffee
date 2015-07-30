# This is to be the include file referenced in the middleware
module.exports = (info, cb) ->
	ext_token = process.env.SLASHTOKEN || undefined
	authorized_users = process.env.SLASHUSERS || undefined
	authorized_channel = process.env.SLASHCHANNEL || "authorized-channel"
	is_authorized = 'no'
	result = {meta: {code: 200, msg: 'OK'}}
	if ext_token != undefined
		if ext_token == info.token 
			if authorized_channel == info.channel_name
				if authorized_users != undefined
					for authorized_user in authorized_users
						if info.user_name == authorized_user
							is_authorized = 'yes'
				else
					# No users set up so lets authorize everyone
					is_authorized = 'yes'
				# Check if user authorized
				if is_authorized == 'yes'
					console.log "Params: " + info.text # User text
					console.log "User: " + info.user_name # User name
					console.log "Channel: " + info.channel_name # User name
					console.log "Command: " + info.command # command
					console.log "Domain: " + info.team_domain # command
				else
					result.meta.code = 401
					result.meta.msg = 'Not authorized'
			else
				console.log info.channel_name
				console.log authorized_channel
				result.meta.code = 401
				result.meta.msg = 'Wrong Channel'	
		else
			result.meta.code = 401
			result.meta.msg = 'Unauthorized Usage'		
	else
		result.meta.code = 401
		result.meta.msg = 'Unauthorized Usage'
	cb(result)
