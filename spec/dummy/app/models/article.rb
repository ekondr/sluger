class Article < ActiveRecord::Base
  sluger :title, :slug, limit: 150
end
