# Reactio

Reactio API Client for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reactio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reactio

## Usage

### include Reactio

```ruby
require 'reactio'
include Reactio

reactio.create_incident('An Incident')
```

And run:

    $ REACTIO_API_KEY='YOUR_API_KEY' REACTIO_ORGANIZATION='YOUR_ORGANIZATION' bundle exec ruby create_incident.rb

### Or instantiate Reactio::Service

```ruby
require 'reactio'

reactio = Reactio::Service.new(
  api_key: 'YOUR_API_KEY',
  organization: 'YOUR_ORGANIZATION'
)
reactio.create_incident('An Incident')
```

### Reactio incidents

- インシデント作成（およびトピック登録）

```ruby
require 'reactio'
include Reactio

reactio.create_incident(
  'サイト閲覧不可',
  status: 'open',
  detection: 'internal',
  cause: 'over-capacity',
  cause_supplement: 'Webサーバがアクセス過多でダウン',
  point: 'application',
  scale: 'point',
  pend_text: 'Webサーバの再起動を行う',
  topic: %w(原因調査 復旧作業),
  notification_text: '至急対応をお願いします',
  notification_call: false
)
```

- 一斉通知

```ruby
require 'reactio'
include Reactio

reactio.notify_incident(
  123,
  notification_text: '至急対応をお願いします',
  notification_call: true
)
```

- インシデント一覧取得

```ruby
require 'reactio'
include Reactio

list = reactio.create_incident(
  from: Time.now - (60 * 60 * 24 * 7),
  to: Time.now,
  status: 'pend',
  page: 1,
  per_page: 50
)

p list.first
#=> {:id=>1, :name=>"サイト閲覧不可", :manager=>nil, :status=>"pend", :detection=>"msp", :cause=>"over-capacity", :cause_supplement=>"Webサーバがアクセス過多でダウン", :point=>"middleware", :scale=>"whole", :pend_text=>"Webサーバの再起動を行う", :close_text=>"Webサーバのスケールアウトを行う", :closed_by=>nil, :closed_at=>nil, :pended_by=>nil, :pended_at=>nil, :created_by=>0, :created_at=>1430208000, :updated_by=>0, :updated_at=>1430208000}
```

- インシデント取得

```ruby
require 'reactio'
include Reactio

p reactio.describe_incident(123)
#=> {:id=>123, :name=>"サイト閲覧不可", :manager=>nil, :status=>"open", :detection=>"msp", :cause=>"over-capacity", :cause_supplement=>"Webサーバがアクセス過多でダウン", :point=>"middleware", :scale=>"whole", :pend_text=>"Webサーバの再起動を行う", :close_text=>"Webサーバのスケールアウトを行う", :closed_by=>nil, :closed_at=>nil, :pended_by=>nil, :pended_at=>nil, :created_by=>0, :created_at=>1430208000, :updated_by=>0, :updated_at=>1430208000, :topics=>[{:id=>1, :name=>"原因調査", :status=>"open", :color=>"#5661aa", :closed_by=>nil, :closed_at=>nil, :created_by=>0, :created_at=>1430208000, :updated_by=>0, :updated_at=>1430208000}, {:id=>2, :name=>"復旧作業", :status=>"open", :color=>"#077f40", :closed_by=>nil, :closed_at=>nil, :created_by=>0, :created_at=>1430208000, :updated_by=>0, :updated_at=>1430208000}], :files=>[{:name=>"障害報告書", :path=>"https://demo.reactio.jp/data/reactio-mvp/files/incident/1/_bYMRLTxj75lcXCWN0iaAZud2CuGqFFL/Screen_Shot.png"}], :users=>[{:id=>1}, {:id=>2}]}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/reactio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
