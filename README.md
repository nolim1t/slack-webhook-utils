# Slack Webhooks Utilities
## About
These are utilities to create your own slack bot.

## TODO
* Create utlity for processing incoming webhooks
* Make an NPM package
* Create an example bot
* Write unit tests

## Usage
### How to use the incoming webhooks API
This will eventually change

```code
o = require "./lib/incoming.coffee"
o {channel: "#random", botusername: "blah", msgtext: "This is a message", url: "https://slack.webhook.url"}, (cb) -> 
    console.log(cb)
```

## Slash Commands
Here are some examples of implementing slash commannds in your app

### Example Usage in Express 4.X router speak
```coffeescript
router.post '/slack', require('./lib/slashcmd.coffee')
```

which also requires the following middleware to be loaded
```coffeescript
	# Middleware to load slack function
	router.use (req, res, next) ->
		req.slackfunction = require './slacker.coffee'
		next()
```

### Contents of slacker.coffee (which perhaps exist in the same folder as the router)
```coffeescript
module.exports = (info, cb) ->
	result = {meta: {code: 200, msg: 'OK'}}
	console.log info.text # User text
	console.log info.user_name # User name
	console.log info.command # command
	cb(result)
```
