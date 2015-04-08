{
    "identifier": "daringfireball_sql",
    "title": "DaringFireball SQL",
    "help": "Submit DaringFireball content to internal database.",
    "endpoint": "sql",
    "payload": {
        "server": "postgresql",
        "host": "127.0.0.1",
        "port": 5432,
        "username": "daring",
        "password": "fireball",
        "database": "daring",
        "query": "INSERT INTO posts(title, content, author, url) VALUES('%{title}', '%{content}', '%{author}', '%{url}');"
    }
}