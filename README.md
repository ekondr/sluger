# Sluger

Sluger is a plugin for generating SEO friendly permalinks. It adds ability to use
alphabetic ID for entities instead of numeric ID.

For instance, without sluger the helper `article_url(article)` returns:

    http://localhost:3000/articles/1

But with sluger this helper will return:

    http://localhost:3000/articles/seo-friendly-name

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sluger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sluger

## Usage

Add a column which will store role/roles as integer:

```ruby
add_column :articles, :slug, :string, null: false, limit: 150
add_index :articles, :slug, unique: true
```

And then tell a model that you use this gem functionality:

```ruby
# app/models/article.rb
class Article < ActiveRecord::Base
  sluger :title, :slug
end
```

## Options

For now the gem has only one option - `limit`. It helps to limit a slug's length. If you set
the limit all extra characters will be cut.

```ruby
# app/models/article.rb
class Article < ActiveRecord::Base
  sluger :title, :slug, limit: 150
end
```

So you can do this:

```ruby
article = Article.create!(title: 'Hello World!')
article.slug # => hello-world
article.title = 'New World!'
article.save! # => hello-world
article.slug = nil
article.save! # => new-world
article.to_param # => new-world
```

## Contributing

1. Fork it ( https://github.com/ekondr/sluger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
