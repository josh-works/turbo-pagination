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

