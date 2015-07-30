# Compatible with Express v4.X
module.exports = (req, res, next) ->
	payload = {meta: {code: 400, msg: 'Invalid Parameters'}}
	# https://api.slack.com/slash-commands
	if req.body != undefined 
		# Process body
		# token, team_id, team_domain, channel_id, channel_name, user_id, user_name, command, text
		if req.body.token != undefined and req.body.team_id != undefined and req.body.team_domain != undefined and req.body.channel_id != undefined and req.body.channel_name != undefined and req.body.user_id != undefined and req.body.user_name != undefined and req.body.command != undefined and req.body.text != undefined
			# Process the request (Look for req.slackfunction)
			if req.slackfunction != undefined
				info = {
					token: req.body.token,
					team_id: req.body.team_id,
					team_domain: req.body.team_domain,
					channel_id: req.body.channel_id,
					channel_name: req.body.channel_name,
					user_id: req.body.user_id,
					user_name: req.body.user_name,
					command: req.body.command,
					text: req.body.text
				}
				req.slackfunction info, (cb) ->
					payload.meta.code = cb.meta.code
					payload.meta.msg = cb.meta.msg
					res.status(payload.meta.code).send(JSON.stringify(payload))
			else
				# req.slackfunction not valid
				res.status(payload.meta.code).send(JSON.stringify(payload))					
		else
			# Bad body params
			res.status(payload.meta.code).send(JSON.stringify(payload))
	else
		# Bo body
		res.status(payload.meta.code).send(JSON.stringify(payload))
