{
	"identifier": "file_template",
	"title": "File management Template",
	"help": "Append sample content to a file on your user workspace.",
	"publisher": "file",
	"payload": {
		"method": "append",
		"uri": "arii_log.csv",
		"content": "${arii.datetime},%{title},%{content},%{url}\n"
	}
}