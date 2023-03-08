![Made With Ruby](https://forthebadge.com/images/badges/made-with-ruby.svg) ![Built With Love](https://forthebadge.com/images/badges/built-with-love.svg)

# SEARQ

API search engine based on RSS feeds

SearQ is a REST API that allows users to search for and retrieve information from RSS (RDF site summary) feeds. Instead of relying on a traditional web crawling method, it leverages the information contained in RSS feeds to present the most relevant and up-to-date results to the user.

The engine works by aggregating information from multiple RSS feeds, indexing the content, and allowing users to search through it using keywords or phrases.

By utilizing RSS feeds, the search results are often more targeted and accurate, making it easier for users to find the information they are looking for. Additionally, because the information is being pulled from a variety of sources, users may also be exposed to a wider range of perspectives and opinions on a given topic.

```sh
curl -G -H "Authorization: Token {TOKEN}" https://searq.org/api/search.json -d "q={q}"
```

```json
{
  "data": [
    {
      "id": "044ac694-6652-4db6-8693-e921dca1bcc8",
      "type": "item",
      "attributes": {
        "title": "Ubisoft's Mousetrap system lengthens the lag to punish 'Rainbow Six Siege' cheaters",
        "text": "Cheaters are why we can't have nice things. All the time, money and effort that could be going towards expanded DLCs and improved gameplay mechanics is instead spent staving off the legions of mediocre players who mistake aimbots for actual gaming prowess. The entire exercise is exhausting and Ubisoft isn't going to take it anymore, the company announced Monday. Come the game's next update release, any 'Rainbow Six Siege' player found cheating through the use of input spoofing — that is, using a third-party device to run a keyboard and mouse on their console instead of a controller — will see their lag times drastically extended. Play stupid games, win stupid prizes.These devices — which include the XIM APEX, the Cronus Zen, or the ReaSnow S1 — allow players to leverage the heightened sensitivity and increased reactions that a keyboard and mouse offer over console controllers...",
        "categories": [
          "sports & recreation",
          "site|engadget",
          "provider_name|engadget",
          "region|us",
          "language|en-us",
          "author_name|andrew tarantola"
        ]
      },
      "relationships": {
        "feed": {
          "data": {
            "id": "fc577ca6-9410-443b-a687-ffa450ce1022",
            "type": "feed"
          }
        }
      }
    }
  ]
}
```

## Mielesearch

SearQ uses [Meilisearch](https://www.meilisearch.com) as search engine. Meilisearch is an open-source, lightning-fast, and hyper-relevant search engine that fits effortlessly into your apps. It is written in Rust and uses LMDB as a storage engine. It is a standalone binary that can be run on any platform. It is also available as a Docker image.

### Features

- **Blazing fast (answers < 50 milliseconds):** Priority is given to fast answers for a smooth search experience.
- **Search as you type:** Results are updated on each keystroke. To make this possible, we use prefix-search.
- **Typo tolerance:** Understands typos and misspellings.
- **Tokenization in English**, Chinese, and all languages that use space as a word divider.
- **Return the whole document:** The entire document is returned upon search.
- **Highly customizable search and indexing:**
    - **Custom ranking:** Customize the relevancy of the search engine and the ranking of the search results.
    - **Stop words:** Ignore common non-relevant words like of or the.
    - **Highlighting:** Highlighted search results in documents
    - **Synonyms:** define synonyms for a better search experience.
- **RESTful API**
- **Search preview:** allows you to test your search settings without implementing a front-end

## Installation

```sh
# Install Meilisearch
curl -L https://install.meilisearch.com | sh

# Launch Meilisearch
./meilisearch
```

You have the option to install Meilisearch locally or deploy it over a cloud service. Learn more about the other installation options on [installation guide](https://docs.meilisearch.com/learn/getting_started/installation.html#local-installation)

#

## Built With

- [Ruby on Rails](https://github.com/rails/rails) &mdash; Our back end API is a Rails app. It responds to requests RESTfully in JSON.
- [Meilisearch](https://www.meilisearch.com) &mdash; An open-source, lightning-fast, and hyper-relevant search engine that fits effortlessly into your apps.
- [PostgreSQL](https://www.postgresql.org/) &mdash; Our main data store is in Postgres.
- [Redis](https://redis.io/) &mdash; We use Redis as a cache and for transient data.
- [Feedjira](https://github.com/feedjira/feedjira) &mdash; Feedjira is a Ruby library designed to parse feeds.
- [Sidekiq](http://sidekiq.org) &mdash; Simple, efficient background processing for Ruby.
- [JSON:API Serialization](https://github.com/jsonapi-serializer/jsonapi-serializer) &mdash; A fast JSON:API serializer for Ruby Objects..
- [TailwindCSS](https://github.com/tailwindlabs/tailwindcss) &mdash; A utility-first CSS framework for rapidly building custom user interfaces.

Plus *lots* of Ruby Gems, a complete list of which is at [/main/Gemfile](https://github.com/searq/searq.org/blob/main/Gemfile).

## Sponsor me

Dear user,

I am writing to you personally to ask for your support in keeping our REST API project free for everyone to use.

SearQ project has been developed with the goal of providing a reliable and efficient tool for developers to integrate into their applications. We understand that as a developer, you rely on SearQ project to save time and resources on developing your own solutions.

Running and maintaining a REST API like SearQ comes with costs, such as server costs, bandwidth, and development time. While we are committed to keeping SearQ project free for everyone, we need your help to keep it that way.

Your contribution, no matter how small, can help me cover the costs of maintaining and improving our REST API. By donating, you are not only supporting us, but also contributing to the greater good of the developer community.

So please consider making a donation to our project. Your support will help me provide a valuable service to the developer community and keep our REST API free for all.

Thank you for your time and consideration.

Sincerely, Davide

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H1F15SD)

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/searq/searq.org>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

SearQ is available as open source project under the terms of the [MIT License](https://opensource.org/licenses/MIT).
