require 'sluger/version'

module Sluger
  extend ActiveSupport::Concern

  class_methods do
    def sluger(*args)
      options = { limit: 255 }
      title_column = args.length > 0 ? args[0] : :title
      slug_column = args.length > 1 ? args[1] : :slug
      options.merge!(args[2]) if args.length > 2 && args[2].is_a?(Hash)
      has_limit = options[:limit] > 0

      self.class_eval do
        before_validation :process_slugering
      end

      define_singleton_method(:slugering) do |entity, title|
        return nil if title.blank?

        new_slug = title.parameterize
        new_slug = title[0, options[:limit]] if has_limit && new_slug.length > options[:limit]

        pk = self.primary_key
        relation = self
        relation = relation.where.not(pk => entity[pk]) unless entity.new_record?

        index = 0
        base_slug = new_slug
        while relation.where("#{slug_column} = ?", new_slug).count > 0 do
          index += 1
          new_slug = base_slug[0, options[:limit] - index.to_s.length - 1] if has_limit
          new_slug = "#{new_slug}-#{index}"
        end
        new_slug
      end

      define_method(:process_slugering) do
        return unless self[slug_column].blank?
        new_value = self[title_column]
        self[slug_column] = self.class.send(:slugering, self, new_value)
      end

      define_method(:to_param) do
        self[slug_column]
      end
    end
  end
end

ActiveRecord::Base.send(:include, Sluger)
