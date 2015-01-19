{
	"identifier": "dropbox_template",
	"title": "Dropbox file Template",
	"help": "Append content to a file in your dropbox.",
	"publisher": "dropbox",
	"payload": {
		"method": "append",
		"uri": "ariip_log.csv",
		"content": "${arii.datetime},%{id},%{title}\n"
	}
}