{
    "identifier": "df_xml",
    "title": "DaringFireball tracker",
    "help": "Check for new content on DaringFireball.",
    "publisher": "xml",
    "schedule": "1h",
    "payload": {
        "uri": "http://daringfireball.net/feeds/main",
        "cache": "id",
        "query": "//entry",
        "selectors": "[{\"title\":\"title\"},{\"author\":\"author/name\"},{\"content\": \"content\"},{\"url\": \"link[@rel='shorturl']\"}]"
    }
}