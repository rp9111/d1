FactoryGirl.define do
  factory :page do
    title         { Faker::Lorem.words(rand(10) + 2).join(' ').titleize }
    content       { Faker::Lorem.paragraphs(rand(99) + 1).join("\r\n") }
    permalink     { title.parameterize(separator: '_') unless title.nil? }
    cover         { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpg')) }
    area
    position      1
    user
    created_at    { rand(400).days.ago }
    publish       true
    commentable   false
    properties    nil
    published_at  { 2.minutes.ago }
    pull_at       nil
  end
end
