# Slack Webhooks Utilities
## About
These are utilities to create your own slack bot.

## TODO
* Create utlity for processing incoming webhooks
* Make an NPM package
* Create an example bot
* Write unit tests

## Usage
### How to use the outgoing bot
This will eventually change

```code
o = require "./lib/incoming.coffee"
o {channel: "#random", botusername: "blah", msgtext: "This is a message", url: "https://slack.webhook.url"}, (cb) -> 
    console.log(cb)
```
