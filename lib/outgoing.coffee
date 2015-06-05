request = require 'request'

module.exports = {
	outgoing: (info, cb) ->
		o = {
			meta: {status: 400, msg: 'Invalid Parameters. Required Parameters are channel, botusername, msgtext, url and optionally emoji, iconurl, dryrun and debug'}
		}
		if (info.channel != undefined && info.botusername != undefined && info.msgtext != undefined && info.url != undefined) 
			payload = {
				"channel": info.channel,
				"username": info.botusername,
				"text": info.msgtext,
			}
			if (info.emoji != undefined)
				payload.icon_emoji = info.emoji
			else
				if (info.iconurl == undefined)
					payload.icon_emoji = ':ghost:'
				else
					payload.icon_url = info.iconurl

			o.meta.status = 200
			o.meta.msg = 'OK'
			if (info.debug == 'yes')
				o.meta.debug = {
					url: info.url,
					payload: payload
				}
			if info.dryrun == undefined
				request {uri: info.url, method: 'POST', headers: {'content-type' : 'application/x-www-form-urlencoded'}, body: JSON.stringify(payload)}, (err,res,body) ->
					if body == 'ok'
						o.meta.status = 200
						o.meta.msg = body
					else
						o.meta.status = 500
						o.meta.msg = body
					cb(o)
			else
				cb(o)
		else
			cb(o)
}
