{
    "identifier": "df_sql",
    "title": "DaringFireball SQL agent.",
    "help": "Read DaringFireball articles from internal database.",
    "publisher": "sql",
    "schedule": "1d",
    "payload": {
        "server": "postgresql",
        "host": "127.0.0.1",
        "port": 5432,
        "username": "daring",
        "password": "fireball",
        "database": "daring",
        "query": "SELECT * FROM posts;",
        "cache": "id",
        "selectors": "[{\"title\":\"title\"},{\"author\":\"author\"},{\"content\": \"content\"},{\"url\": \"url\"}]"
    }
}