
# INTRODUCTION

Below are several examples of REST calls using the excellent TOOL [httpie](https://httpie.io)

HTTPie (pronounced aitch-tee-tee-pie) is a command-line HTTP client. Its goal is to make CLI interaction with web services as human-friendly as possible. HTTPie is designed for testing, debugging, and generally interacting with APIs & HTTP servers. The http & https commands allow for creating and sending arbitrary HTTP requests. They use simple and natural syntax and provide formatted and colorized output.

# TOKENS

The tokens endpoint allows tokens useful for authentication to be generated and updated


https POST searq.org/api/tokens
https -A bearer -a {token} POST searq.org/api/tokens


# SEARCH

The search endpoint enables searches within the elements taken from all RSS FEEDs.

https -A bearer -a {token} GET searq.org/api/search q=={q}
https -A bearer -a {token} GET searq.org/api/search q=={q} direction==asc limit==2


# FEEDS

The feeds endpoint allows you to manage all operations concerning RSS feeds, which are the data sources.


https -A bearer -a {token} GET searq.org/api/feeds/search q={q}
https -A bearer -a {token} GET searq.org/api/feeds
https -A bearer -a {token} GET searq.org/api/feeds page={page}
https -A bearer -a {token} GET searq.org/api/feeds/tasks
https -A bearer -a {token} GET searq.org/api/feeds/tasks page={page}
https -A bearer -a {token} GET searq.org/api/feeds/{id}
https -A bearer -a {token} POST searq.org/api/feeds url={url}


# ITEMS

The items endpoint allows you to view and list the elements of a feed

https -A bearer -a {token} GET searq.org/api/feeds/{feedId}/items
https -A bearer -a {token} GET searq.org/api/feeds/{feedId}/items/{id}


# TASKS

Le point de terminaison des tâches permet de visualiser et de répertorier les tâches. Les tâches sont des objets indiquant des opérations asynchrones telles que feed_create et feed_update.

https -A bearer -a {token} GET searq.org/api/tasks
https -A bearer -a {token} GET searq.org/api/tasks page={page}
https -A bearer -a {token} GET searq.org/api/tasks/{id}



# EXAMPLE SEARCH

```sh
https -A bearer -a {token} GET searq.org/api/search q=={q}
```

```json
{
  "data": [
    {
      "attributes": {
        "categories": [],
        "feed": {
          "id": "8a3247b5-cc35-45a3-ac05-f50d8d42ab53",
          "title": "Ruby News",
          "url": "https://www.ruby-lang.org/en/feeds/news.rss"
        },
        "published_at": "2023-02-08T12:00:00.000Z",
        "published_at_timestamp": 1675857600,
        "text": "Ruby 3.2.1 has been released. This is the first TEENY version release of the stable 3.2 series. See the GitHub releases for further details.",
        "title": "Ruby 3.2.1 Released",
        "url": "https://www.ruby-lang.org/en/news/2023/02/08/ruby-3-2-1-released/"
      },
      "id": "6b64a7df-11d0-453f-9396-578987aff909",
      "relationships": {
        "feed": {
          "data": {
            "id": "8a3247b5-cc35-45a3-ac05-f50d8d42ab53",
            "type": "feed"
          }
        }
      },
      "type": "item"
    }
  ]
}
```

# EXAMPLE FEED CREATE

```sh
https -A bearer -a {token} POST searq.org/api/feeds url={url}
```

```json
{
  "data": {
    "attributes": {
      "enqueued_at": "2023-03-09T08:26:22.753Z",
      "error_message": null,
      "finished_at": null,
      "started_at": null,
      "status": "enqueued",
      "task_type": "feed_store"
    },
    "id": "9c096ab3-d58a-4854-ba23-cbc459c09d44",
    "relationships": {
      "feed": {
        "data": {
          "id": "2d88ba06-3f25-44ab-8fe3-1475f7828f87",
          "type": "feed"
        }
      }
    },
    "type": "task"
  }
}
```