request = require 'request'

module.exports = {
	outgoing: (info, cb) ->
		o = {
				meta: {status: 400, msg: 'Invalid Parameters. Required Parameters are channel, botusername, msgtext, url and optionally emoji and debug'}
			}
		if (info.channel != undefined && info.botusername != undefined && info.msgtext != undefined && info.url != undefined) 
			icon_emoji = ':ghost:'
			if (info.emoji != undefined)
				icon_emoji = info.emoji

			payload = {
				"channel": info.channel,
				"username": info.botusername,
				"text": info.msgtext,
				"icon_emoji": ":ghost:"
			}
			o.meta.status = 200
			o.meta.msg = 'OK'
			if (info.debug == 'yes')
				o.meta.debug = {
					url: info.url,
					payload: payload
				}

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
}
