Intention
=======

This intention of this project is to act as a playground for Chimp candidates to submit their coding samples and projects to. If you have any questions about anything please fire them towards [harrison@chimp.net](mailto:harrison@chimp.net). 

Requirements - Details
=======

Please create a website. This website can be contructed in the language of your choosing. 

Please import the file "data.csv" (located in the root of this project) into a database. This dataset will be used as the source sample data for the project. Each line-item in the csv represents a single *Group* object.

When visiting the root path of the website you should display a page that allows you to select a *Group*. Once a *Group* has been selected, the page should additionally display a valid block of HTML code that can be copied and pasted onto any other web site.

When you copy and paste this HTML code into another site, and subsequently load that site in your browser, that site should display the *Group Name* along with the *Group Balance* (from the *name* and *balance* fields in the CSV) at the location on the page where you pasted your generated HTML snippet. These two values (*Group Name* and *Group Balance*) should be retrieved dynamically.

Please fill in the placeholder sections below once completed with all necessary information.

How To Run
=======
This is a Rails 4 web app. You can run it using your system's ruby/bundler or docker (if you don't have ruby installed).

To run with your system's ruby toolchain, `cd` to the web app directory and run:

```bash
bundle install
bundle exec rake db:setup
bundle exec rake test --verbose
bundle exec rails server --binding 0.0.0.0
```

To run using docker, `cd` to the web app directory and run:

```bash
docker build -t geokat .
docker run -it -p 3000:3000 geokat
```

In both cases the running app will listen on port 3000.

How To Test
=======
To see the HTML snippet for a group, click on the HTML link in the group's row.
To run the test suite, run `bnndle exec rake test --verbose`.

Other Info
=======
(Please justify any interesting choices or decisions you made here.)

I used JSONP for cross-origin sharing. Ajax wouldn't work because of the same origin policy.

The app returns padded JSON when JSON request includes a callback query parameter (e.g. `http://localhost:3000/groups/1.json?callback=cbFunc`). To this end, I included an `after_action` filter in the Groups controller (https://goo.gl/uioD1t). I also wanted to make sure that the server handles errors for JSONP calls gracefully--always returning 200 OK and including the error in the padded JSON response. To achieve that, I use an `around_action` filter (https://goo.gl/36pwpu). I also included functional tests for such calls (https://goo.gl/I8gDNd).

I used `rails generate scaffold` to create a basic CRUD app. I used Bootstrap for the UI.
