 class SitemapController < ApplicationController
   def index
     @static_pages = [root_url, about_url, contact_url, help_url]
     @users = User.all
     @posts = Post.all
     respond_to do |format|
       format.xml
     end
   end
 end
