require 'rails_helper'

RSpec.describe Sluger, type: :model do
  context 'given an object' do
    let!(:article) { Article.create!(title: 'Hello World') }

    it 'should have a slug' do
      expect(article.slug).to eq 'hello-world'
      expect(article.to_param).to eq 'hello-world'
    end

    context 'when a title is changed' do
      it 'should have an old slug' do
        article.title = 'New World!'
        article.save!
        expect(article.slug).to eq 'hello-world'
      end
    end

    context 'when a slug is set to nil' do
      it 'should generate a new slug' do
        article.title = 'New World!'
        article.slug = nil
        article.save!
        expect(article.slug).to eq 'new-world'
      end
    end

    context 'given another object with the same title' do
      let!(:article2) { Article.create!(title: 'Hello World') }

      it 'should have another slug' do
        expect(article.slug).to eq 'hello-world'
        expect(article2.slug).to eq 'hello-world-1'
      end
    end
  end

  context 'given an object with cyrillic characters' do
    let!(:article) { Article.create!(title: 'Слава Україні!') }

    it 'should have a latin slug' do
      expect(article.slug).to eq 'slava-ukrayini'
      expect(article.to_param).to eq 'slava-ukrayini'
    end

    context 'when a length of slug is greater than a limit' do
      it 'should cut extra characters' do
        article.title = 'Слава Україні! ' * 20
        article.slug = nil
        article.save!

        expect(article.slug.length).to eq 150
      end
    end
  end
end
