module Sluger
  module Generators
    class LocalesGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      argument :locale_code, type: :string, default: 'uk'

      desc 'Add localizations for transliterating.'
      def copy_initializer_file
        copy_file "#{locale_code.downcase}.yml", "config/locales/sluger.#{locale_code.downcase}.yml"
      end
    end
  end
end
