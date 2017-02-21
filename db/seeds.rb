require 'factory_girl_rails'

def clean_up_assets
  puts 'deleting uploads'
  `rm -rf #{Rails.root}/public/content`
  `rm -rf #{Rails.root}/public/uploads`
end

def wipe_out(table)
  puts "wiping out #{table.pluralize}"
  table.singularize.classify.constantize.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence!(table.downcase.pluralize)

end

def dot(char = '.')
  print char
  $stdout.flush
end

def line(text)
  puts ''
  puts text
end

# Limit how deep the comments can run
@max_comment_level = 2
@comment_level = 0

def create_comment(page, responses = 0, parent = nil)
  return unless (0..3).to_a.sample == 0
  @comment_level += 1
  puts "comment_level #{@comment_level}"
  comment = FactoryGirl.create :comment,
    page: page,
    in_response_to: parent,
    user_id: @user_ids.sample
  dot
  rand(responses).times { create_comment(page, responses, comment) } if @comment_level <= @max_comment_level
  @comment_level -= 1
end

line 'removing table data and stale assets'
clean_up_assets
wipe_out 'user'
wipe_out 'area'
wipe_out 'page'
wipe_out 'comment'
wipe_out 'group'

line 'creating user groups: premium, standard, trial'
admin = Group.create name: 'premium'
admin = Group.create name: 'standard'
admin = Group.create name: 'trial'

group_ids = Group.all.collect &:id

line 'creating admin (user name: "admin", password: "password").'
admin = User.create user_name: 'administrator', email: 'e@mail.com', password: 'password', admin: true

line 'creating 100 additional users.'
100.times do
  begin
    FactoryGirl.create :user, group_id: group_ids.sample
  rescue Exception => e
  end
  dot
end
@user_ids = User.all.collect &:id

line 'creating Home area'
home_area = Area.create name: 'Home', label: 'Home', mode: 'carousel'
line 'creating 5 carousel slides for the Home area'
5.times do
  Page.create user: admin,
  title: Faker::Lorem.words(rand(10) + 2).join(' ').titleize,
  area: home_area,
  content: Faker::Lorem.paragraphs(rand(100)).join("\r\n"),
  published_at: rand(400).days.ago,
  cover: "https://placeimg.com/640/480/any#{ rand(100) }.jpg"
  dot
end

line 'creating Blog area'
blog_area = Area.create name: 'Blog', label: 'Blog', mode: 'parallax'

line 'creating 15 blog entries'
15.times do
  Page.create user: admin,
  title: Faker::Lorem.words(rand(10) + 2).join(' ').titleize,
  area: blog_area,
  content: Faker::Lorem.paragraphs(rand(100)).join("\r\n"),
  published_at: rand(400).days.ago,
  cover: "https://placeimg.com/640/480/any#{ rand(100) }.jpg"
  dot
end

line 'creating Forum area'
forum_area = Area.create name: 'Forums', label: 'Forums', mode: 'threaded', comments: true
line 'creating 15 forum topics'
15.times do
  date = rand(400).days.ago
  page = FactoryGirl.create :page,
    user_id: @user_ids.sample,
    area: forum_area,
    content: Faker::Lorem.paragraphs(rand(2) + 1).join("\r\n"),
    created_at: date + 1,
    published_at: date
  dot
  responses = rand(8)
  if responses > 0
    line "creating #{responses} topic comments"
    responses.times { create_comment page, responses }
  end
end

line 'creating dave (user name: "dave", password: "password").'
admin = User.create user_name: 'dave', email: 'dgerton@gmail.com', password: 'password', admin: true

line 'creating brian (user name: "fling", password: "password").'
admin = User.create user_name: 'fling', email: 'fling@me.com', password: 'password', admin: true

puts
puts 'Done'
puts
