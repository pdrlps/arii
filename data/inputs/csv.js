{
	"identifier": "names_csv",
	"title": "Names monitor",
	"help": "Load a list of fake names, available in CSV format.",
	"publisher": "csv",
	"schedule": "1d",
	"payload": {
		"uri": "http://pedrolopes.net/ariip_names.csv",
		"headers": true,
		"delimiter": ",",
		"cache": "0",
		"selectors": "[{\"country\":4},{\"email\":5},{\"username\": 6}]"
	}
}