working through https://dev.to/davidcolbyatx/pagination-and-infinite-scrolling-with-rails-and-the-hotwire-stack-34om

Install `Faker`, add to `seeds.rb`:

```ruby
50.times do |n|
  Widget.create(name: Faker::Appliance.equipment)
end
```

```
b rails db:create
b rails db:migrate
b rails db:seed
foreman start -f Procfile.dev
```

```ruby
# routes.rb
root to: "widgets#index"
```

and visit `localhost:3000`. Beautiful widgets.

Now, adding `pagy` to give regular pagination options.

update `application_controller.rb`, `application_helper.rb`, `widgets_controller.rb`, and `index.html.erb`

restart the server, reload the page, and it looks great!

Here's the commits so far:
```shell
* aa66a95 - (HEAD -> main) Add Pagy and basic pagination (5 seconds ago) <Josh Thompson>
* b7f23f5 - rails new turbo-pagination --css=tailwind -d=postgresql (12 minutes ago) <Josh Thompson>
```

OK, next we added Turbo Frames, to swap out the HTML in _just_ the part of the page we specify.

This feels like magic. Feels like React, in terms of easy changes.

In `app/views/widgets/index.html.erb`, we changed a `div` to `turbo_frame_tag` with a property `autoscroll: "true"`. 

Autoscroll moves the browser to the top of the next page of results.

Moved the contents to a partial, and in the partial, added a `data: { turbo_action: "advance" }` property to the `link_to` button. This `advance` bit handles pagination in the browser so histories work as expected

------------------

Last commit. Not going to go over all of it, don't understand it all, but, at a high level, are changing to a `load more widgets` button, instead of pagination, and we auto-append more widgets to the HTML. 

in `ApplicationController`, wrote a `before_action` titled `:turbo_frame_request_variant`, which gives us the ability (I think) to detect `turbo_frame` requests, instead of normal html and json requests.

next, in our `pager` partial, we're creating a turbo_frame titled `page_handler`. 

We created `app/views/widgets/index.html+turbo_frame.erb` (what a filename!)

and in it, it's the `turbo_frame_tag "page_handler"`, wich a `turbo_stream_action_tag` for both `append` and `replace` actions. I don't fully understand why we have to append _and_ replace, but i'll get it at some point. 

We updated our `index.html.erb` to also wrap the widgets in a `turbo_frame tag "page_handler"` method.

And we're done! Lets deploy to heroku, and see what happens...

https://turbo-pagination-tutorial.herokuapp.com/

lets see, adding:

```
bundle lock --add-platform x86_64-linux
```

then add/commit/push, then:

```
heroku run rails db:migrate
heroku run rails db:seed
```

Ah, to run in production, I cannot have `Faker` inside a `dev` or `test` block in my Gemfile...

Fixing that, re-seeding the DB, and... I think we're in a good spot.

OK, added a 1:many relationship, just for fun and practice.

a scaffold, two extra migrations, and a little wiring up, and the `db:seed` function still works, and now we've got this `brand` thing:

```
rails g scaffold Brand name:string
rails g migration AddBrandToWidgets brand:references
rails g migration AddUniquenessConstraintToBrands
```

and... it looks nice.

## Tailwind navbar

Now working through https://www.better.dev/making-tailwind-css-navbars, to learn to add a tolerable nav bar via tailwind.

so far:

```HTML+ERB
<nav class="bg-black">
  <div class="max-w-7xl mx-auto border border-red-400">
    <div class="py-32 text-center">
      <h2 class="font-extrabold text-6x1">Widgets And Brands!</h2>
    </div>
    
  </div>
</nav>
```

### tailwind stuff

- `bg-black` sets background color
- `max-w` max-width
- `mx-auto` sets margin on both sides to center
- `py` = `padding-y`
- `flex` is clutch. `flex justify-between` and `flex space-x-4` is nice.

```html
<a href="#" class="py-3 px-3 bg-yellow-400 text-yell0w-800 rounded">Signup</a>
```

That makes a nice signup button.

```
hover:text-gray-900
```

makes a nice mouse-over effect.

OK, deployed to heroku - cannot run rails console commands from this wifi network, so had to log onto heroku and run from the web UI. 

