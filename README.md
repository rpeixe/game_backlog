# 🎮 Game Backlog

A Ruby on Rails application that lets users track video games in their backlog and monitor the best available deals in real time.

---

## 🚀 Features

* 🔍 Search for games via external API
* 📚 Personal backlog with status tracking (playing, completed, etc.)
* 💸 Automatic price fetching from CheapShark API
* ⚡ Real-time price updates using ActionCable (WebSockets)
* 🔄 Background jobs with Sidekiq
* 🧠 Redis-powered caching to reduce API usage
* 🛒 Direct links to the best deals
* 🧹 Automatic cleanup of unused games

---

## 🏗️ Tech Stack

* Ruby on Rails
* PostgreSQL
* Redis
* Sidekiq
* ActionCable
* TailwindCSS
* RSpec
* WebMock

---

## ⚙️ Setup

### 1. Clone the repository

```bash
git clone https://github.com/rpeixe/game_backlog.git
cd game_backlog
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Setup database

```bash
rails db:create
rails db:migrate
```

### 4. Start services

Make sure Redis is running:

```bash
redis-server
```

Then start the app:

```bash
bin/dev
```

And in another terminal:

```bash
bundle exec sidekiq
```

---

## 🔌 External API

This project uses the CheapShark API to fetch game deals.

* Search games
* Fetch deals and prices
* Retrieve store information (with logos)

---

## ⚡ Real-Time Updates

Price updates are processed in the background and pushed to the frontend using ActionCable.

Flow:

```
Sidekiq Job → Redis → ActionCable → Browser UI
```

---

## 🧠 Caching Strategy

Redis is used for caching:

* Game search results (short TTL)
* Game deal lookups (medium TTL)
* Store metadata (long TTL)

This reduces API calls and improves performance.

---

## 🧹 Data Cleanup

A scheduled job removes unused games:

* Games with no backlog entries
* Older than a defined threshold (e.g. 7 days)

---

## 🧪 Testing

Run tests with:

```bash
bundle exec rspec
```

Testing includes:

* Model validations and scopes
* Background jobs
* API integrations (mocked with WebMock)

---

## 📈 Future Improvements

* Add game reviews
* Price history tracking and charts
* Price drop notifications
* Filtering by store
* User-defined price alerts

---

## 📄 License

MIT License

---

## 🙌 Acknowledgements

* CheapShark API for game deal data
* Rails community for excellent tooling
