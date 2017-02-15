# API for USDA Child Nutrition Database
The USDA Child Nutrition Database (CND) can be a difficult thing to navigate especially if you're not using Access. This provides a self hosted method of getting information from the database through a simple API.

Currently using CN20-7 database. Repo will be updated to CN21 once made available by the USDA.

*Full Documentation coming soon*

## Setup

### Import CND

A SQL version of the CND is located in vendor/releases. A class is available to import all of the data into their respective tables. 

`ImportRelease.perform`

*Note: the CND does include alcoholic beverages. By default, the import class will destroy those items. An option will eventually be available to toggle that functionality*

### Creating Users

Devise is used for user authentication. From the rails console, run:

`User.create(email: "email@example.com", password: "password", password_confirmation: "password")`

All of those fields are required, since the system is read-only from the API, no roles are necessary. 

## Documentation

### Obtaining an authentication token

One session is permitted per user at a time. To sign in:

`POST: /api/1/sessions?user[email]=email@example.com&user[password]=password`

This will return:

```
{
  user_id: 1,
  token: s0m3hAShk3yliKethis
}
```
*As you can tell, this isn't very secure. Session keys will be moving to the headers instead of route params very very soon.*

### Authenticating Requests

On each request, pass an 'Authentication' header with your token and user_id. Here's an example if you're using HTTParty in another Ruby project. 

```
class YourApiClass
  include HTTParty
  base_uri "https://api.example.com"
  
  def get_recipes
    token = "my_token"
    user_id = 1
    self.class.get("/api/1/recipes", query: query, headers: {"Authorization" => "Token token=\"#{token}\", user_id=\"#{user_id}\""})
  end
end
```

You are, of course, free to use whatever you want to make this request. 

### Reading the Recipes
Now for the good stuff.

`GET: /api/1/recipes`

**Options (All optional)**

`page` *Default: 0*

`per_page` *Default: 25*

## Forking
This is far from complete and would love any extra code you'd like to add :)

For LunchTray's purposes, we were only concerned with the Recipes. The good news, the Import jobs adds everything to your Rails DB. So adding other controllers literally only requires adding the controllers. The models should be good to go.

## To-Do List
1. Move login info to the headers
2. Add Rspec Tests
3. A bunch of refactoring
4. Add controllers for other models
5. Add interface for managing users

## Hosted Version

LunchTray hosts our own version of this. If you would like to use that instead of self-hosting email me: noah (at) getlunchtray (dot) com and I'm sure we can work something out. 
