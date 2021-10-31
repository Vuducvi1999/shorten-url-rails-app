## List APIs
Asume you use http://localhost:3000 at server

	 public				no require
     check_access! 			require access_api or token 
     authorized! 			require token only
     
 1. POST http://localhost:3000/sign-up `public`
	
**input:** name, email, password
  
**output:** user created with **bcrypt** hash password
  
* if valid: return **jwt token** string and user info (name, email, **access_api**)
  * access_api: use for integrate other platform, using as query url or putting at body request
    * TH1: query url like http://localhost:3000/compress?access_api=AX3zRt with  access_api=AX3zRt
    * TH2: putting at body request, likely send any data to server

* if invalid: return list errors when:
  * name: empty
  * email: empty, invalid format, existed
  * password: empty
  
 2. POST http://localhost:3000/sign-in `public`
     
     **input:** email, password
     
     **output:**
     * if valid: return token and user info (name, email, access_api)
     * if invalid: return list errors
	     * email: can't find
	     * password: incorrect
	     
3. POST http://localhost:3000/compress `check_access!` 
	
**input:** origin_url 
  
**output:** 
  * if valid: return shorten_url and user info (name, email, access_api) 
    * shorten_url format: http://localhost:3000/dZVzVx2 with dZVzVx2 is **alias**, alias like id of every shorten_url in database

  * if invalid: return a error `invalid url` if status respond origin_url =404 or take too long time to respond
  
4. GET http://localhost:3000/links `check_access!`
	
  listed compress data is `paginated`, that mean all compress data is divide into many separate pages, each page has different compress data
  
**input:** page number
  
**output:** array of compress data (origin_url, shorten_url, clicked, created_at, updated_at), current page, total_pages
  * if requested page is bigger than total_pages, array of compress data is empty []
  
5. GET http://localhost:3000/detail/:alias `check_access!` 

**input:** alias of expected shorten_url as params

**output:**
 * if valid: compress data (origin_url, shorten_url, clicked, created_at, updated_at)
 * if invalid: a error message `entity not found`
 
6.  DELETE http://localhost:3000/destroy/:alias `check_access!` 
    
**input:** alias of expected shorten_url as params

**output:**
 * if valid: return data success is true
 * if invalid: a error message `entity not found`
   
7. PATCH http://localhost:3000/edit/:alias `check_access!` 

**input:** alias of expected shorten_url as params

**output:**
 * if valid: return data success is true
 * if invalid: a error message `entity not found`
	
## Shorten Url Algorithm
Each origin_url will be identified by an alias string (7 charactors) which is created by a random base58 string.

* base36 may contain a-z, 0-9

* base58 may contain A-Z, a-z, 0-9 (exclude "0", "O", "I", "l")

* base64 may contain A-Z, a-z, 0-9, "+", "/" and "="

I choose base58 string because it is wise enough for uniqueness and it is not conflict when pass as params to url api (if we use base64, alias will contain "/" which is danger for passing to url api). 

I also refer to tinyurl and bitly work, they seem likely using base58 for alias. 


## Setup for testing app 

This is backend repo, the client repo is [here](https://github.com/Vuducvi1999/shorten-url-rails-app-client)

When you clone them, we will follow these steps:

**With server Rails** 

Step 1: check ruby version, and switch to 2.7.3 `rvm use 2.7.3` or `rbenv local 2.7.3`

If you don't want to install rvm or rbenv, just simply go to Gemfile and change `ruby '2.7.3'` to your global ruby version 

Step 2: go to database.yml file and change username and password to yours database

    username: <%= Rails.application.credentials.username_db %>
    password: <%= Rails.application.credentials.password_db %>

Step 3: run following commands

  `bundle install`
  
  `rails db:create db:migrate`
  
  `rails server`

<div id='change_port'></div>
Your server is start now. If you use another port like 3001. We must go to step 4

Step 4: go to `config/environments/development.rb` file and change port, for example: server port now is 3001

`Rails.application.default_url_options = { :host => 'localhost:3000' }`

into

`Rails.application.default_url_options = { :host => 'localhost:3001' }`

Step 5: run `rails server` again

**With client React** 

Step 1: if your server port is different than 3000 (like 3001). We have mentioned [here](#change_port)

We need to change server port config at client.

Go to `src/constants/index.js` and change

`export const root_server = 'http://localhost:3000'`

into

`export const root_server = 'http://localhost:3001'`

Step 2: run following commands

  `yarn install`
  
  `yarn start`

Done!







