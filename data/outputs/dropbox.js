{
	"identifier": "dropbox_template",
	"title": "Dropbox file",
	"help": "Append content to a file in your dropbox.",
	"endpoint": "dropbox",
	"payload": {
		"method": "append",
		"uri": "ariip_log.csv",
		"content": "${arii.datetime},%{id},%{title}\n"
	}
}