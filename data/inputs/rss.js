{
    "identifier": "svbtle_rss",
    "title": "Feed",
    "help": "Monitor content from RSS feed. Beware that there are multiple feed standards (RSS, RSS2, Atom...), make sure that these settings match your input data.",
    "publisher": "xml",
    "schedule": "5m",
    "payload": {
        "uri": "http://pedrolopes.svbtle.com/feed",
        "cache": "id",
        "query": "//entry",
        "selectors": "[{\"title\":\"title\"},{\"content\":\"content\"},{\"url\": \"link/@href\"}]"
    }
}