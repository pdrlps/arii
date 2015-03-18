{
	"identifier": "daring_endpoint",
	"title": "DaringFireball file",
	"help": "Append DaringFireball content to a file on your workspace.",
	"publisher": "file",
	"payload": {
		"method": "append",
		"uri": "daring_fireball.csv",
		"content": "${arii.datetime},%{title},\"%{content}\",%{url},\"%{author}\"\n"
	}
}