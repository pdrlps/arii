{
    "identifier": "daringfireball_mail",
    "title": "DaringFireball mail.",
    "help": "Send DaringFireball data via mail.",
    "endpoint": "mail",
    "payload": {
        "to": "pedrolopes@ariip.com",
        "cc": "email@email.com",
        "bcc": "email@email.net",
        "subject": "New DaringFireball post with %{title}",
        "message": "<b>Title:%{title}</b><br /><br/>%{content}<br />Published by %{author}<br/>${arii.datetime}"
    }
}