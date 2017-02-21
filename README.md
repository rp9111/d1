## ![](https://github.com/IamNaN/iridium/blob/master/public/apple-icon-76x76.png) Iridium

### Liquid

Here is a sample liquid template that demostrates all of the exposed properties.

```handlebars
<body>
  <div>
    <h1>{{ area.name }} Area</h1>
    <dl>
      <dd>User      : {{ user.name }}</dd>
      <dd>Username  : {{ user.user_name }}</dd>
      <dd>Email     : {{ user.email }}</dd>
      <dd>Subscribed: {{ subscription.active }}</dd>
      <dd>Expired   : {{ subscription.expired }}</dd>
      <dd>New       : {{ subscription.create_url }}</dd>
      <dd>Renew     : {{ subscription.renew_url }}</dd>
      <dd>Cancel    : {{ subscription.cancel_url }}</dd>
    </dl>
  	{% if page %} {% comment %} <!-- then display the page --> {% endcomment %}
      <h2>{{ page.title }} Page</h2>
{{ page.content }}
      <nav>
        {% if page.previous_page %}
          <li>Prev: <a href="{{ page.previous_page.url }}">{{ page.previous_page.title }}</a></li>
        {% endif %}
        {% if page.next_page %}
          <li>Next: <a href="{{ page.next_page.url }}">{{ page.next_page.title }}</a></li>
        {% endif %}
      </nav>
  	{% else %} {% comment %} <!-- then show a table of contents --> {% endcomment %}
      <ul>
        {% for page in area.contents %}
          <li><a href="{{ page.url }}">{{ page.title }}</a></li>
        {% endfor %}
      </ul>
	  {% endif %}
  </div>
</body>
```

### Flexible, Extensible Rails Application Foundation

Iridium is a complete yet runtime-customizable website designed to be the foundation for your application. I use this as the starting point for other projects and thought others might get some use out it as well.

Iridium has two sides: a public interface and an admin interface. The public side is presented to site visitors. The admin side is reserved for administrators and is used to manage content, permission and presentation of the site.

### Included in Iridium

It is as lightweight as possible but contains:

* a User model with optional twitter, facebook, and instagram integration via omniauth. It can post a tweet or facebook status update if the user has those services authorized. The User model is loosely tied to other models so rolling your own should be easy.
* an Area model used to define and separate sections of the site, so you can segment your site at runtime into areas of different formats such as a Home Page with a scrolling slideshow, a FAQ with an index, a forum area with conversation threading, blog with comments, etc.
* an Admin namespace for configuring and managing the site. The controllers and views of the admin interface can be used as patterns for your own additions.
* a dynamic navigation menu and footer menu which is constructed from via options you set in the admin side.
* a Page model, which is the content for the sections.
* a Group model that separates and organizes the users and to which permissions for access and management can be applied to Areas.
* a model and facility for Comments on Pages that and be configured by group.
* image uploading and processing for User avatars and Page content.

### What does it look like

Most websites can be generalized into "content" and the "areas" to which the content belongs. For example a blog has content called "posts" which usually belongs to a "category", "topic", or in the case of a multi-user blog site, an "author". A forum is similar in having "posts" and "topics", as is a FAQ with its "questions" and "answers". These significantly differ only in the way they display the content: newest or oldest content first, threaded or unthreaded, etc.

#### Areas

The site is broken down into "Areas", which are defined in the admin interface. Areas can be anything, like Home, Blog, About, Terms, FAQ, etc. and may or may not appear as buttons in the main navigation bar or as links in the footer bar. Areas are containers for collections of Pages -- more on Pages in a moment. You assign each Area a presentation mode (e.g. a layout), which is how the Pages are to be displayed together in that Area. Some presentation mode examples are an image carousel (ex: a home page with a full-page hero image slideshow), an article stream (ex: a blog with posts), threaded posts (ex: a forum), etc.

Beside their presentation modes, Areas have some other attributes associated with them that affect the look and feel. Examples are ordering (whether content is supposed to appear oldest-first, newest-first, trending, or most popular) and if comments are allowed. It is important to note that Areas do not contain content themselve. Content belongs to the Pages within the Area.

#### Pages

Pages are discrete pieces of content. For example an article, post, page, photo, etc. which are really the same thing as far as Iridium is concerned. A Page can be in Draft Mode, be scheduled to appear in its Area at a later date and time, and likewise scheduled to be removed in the future.  It has a title and a cover image, and it is configurable whether or not they will be displayed in the Area.

### Opinion
Just like Rails itself, Iridium is opinionated but doesn't exclude the possibility for you to gut portions of it and use your own. The idea is to give you enough to get going immediately, and then start implementing and replacing features as necessary at your own pace. Most of your time will probably be spent in the templates, customizing the user interface.

* I chose to forego Devise and implement my own authentication with the help of OmniAuth. Authentication and the User model are loosely coupled with each other and to the rest of the app so implementing something else, even Devise, should be straight forward.
* After much consideration, I decided to leave the authorization choice and implementation up to you. I sometimes roll my own or use Pundit but there are a lot of CanCanFans out there.
* CoffeeScript and jQuery are included but I believe "modern javascript framework" is an oxymoron so that's as far as the javascript goes here. If desired, replacing CoffeeScript with ECMA 5 or 6 should be fairly effortless since there is very little CoffeeScript in the project.
* Bootstrap 4 (although only the stylesheets are used) is included in this version, but only for the Admin interface. The hope is you'll use it to design your own public interface or use a theme such as is available at WrapBootstrap.com, etc. You could, of course, replace Bootstrap 4 with Bootstrap 3, Pure.css, Foundation, Bulma or just about anything else.

### Some things you need to change

As just mentioned, you need to customize the presentation modes by creating the stylesheets and views for the public interface. Iridium gives you several presentation modes to use as patterns for adding your own, which can be integrated by adding your ERB view template folder and then adding your template to the array of modes. An example of where you might do this is created a product gallery area.

### Some things you might want to change

Pages are written by admins. However, you may want to create an Area where anyone who is registered can create a new Page within. For instance, you may want to create a forum Area that allows people to submit a post. You can create a Group that has permission to create content, but you will need to go into the controller and view code and write a public interface that exposes new and edit to this group of user -- you wouldn't want them to do that through the Admin interface.

But think twice... there might be a better way to do what you that. For instance, in the example above, you could allow threaded Comments in that Area. The root Comments would appear just as a Page would to the user but you wouldn't need to modify any code.

### Contributing
Development has just started and lots of changes are in the works. It's actually probably not a good time to start using this project for your own work because of the code churn that will be happening through the next few weeks. Therefore, currently contributions are closed. But feel free to open an issue if you see something glaring or want to proffer a question or suggestion.

More information is coming, but for now this project is on the bloody edge with:

* ruby 2.3.0
* rails 5.0.0.beta3
* postgres 9.4.5
* bootstrap 4.0.0-alpha.2

Todo:

* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
