# Guide to Solving and Reviewing Sinatra Basic Forms

## Navigate first
- Start up the server, see what we have at hand
- Go to the show page for a song, see all the attributes we have for a song
    + (Title, Album, Artist, Genre, Length)
- Click on the Edit button

## RSpec
- Go through the failing tests, reconcile with the expectations in the README
- First error should be: `first visits a song show page and clicks edit (FAILED - 2)`
    
    ```ruby
    Failure/Error: expect(page).to have_content 'Save Changes'
       expected to find text "Save Changes" in "Sinatra doesn’t know this ditty. Try this: # in app.rb class App get '/songs/1/edit' do \"Hello World\" end end"
    ```

- Second error should be: `changes artist and saves changes (FAILED - 1)`
    ```ruby
     Failure/Error: fill_in('Artist Name', :with => 'Nirvana')
     Capybara::ElementNotFound:
       Unable to find field "Artist Name"
    ```

### Fixing the First Error
- This error is a result of a route not existing for the `edit` template. Let's go ahead and make this in `app/controllers/app.rb`.
    
    ```ruby
    get '/songs/:id/edit' do
      @song = Song.find(params[:id])
      erb :'songs/edit'
    end
    ```

- Now the page will render when we go to that path. Currently, the `edit.html.erb` template is empty. How should we fill in the data? Let's look at the error message. It looks a lot like there's a missing form, right? Let's add in the form.

    ```ruby
    <form action="/songs/<%=@song.id %>" method="post">
  <label for="song-title">Song Title</label>
  <input type="text" name="song[title]" value="<%= @song.title %>" id="song-title"><br>
  <label for="artist-name">Artist Name</label>
  <input type="text" name="song[artist]" value="<%= @song.artist %>" id="artist-name"><br>
  <label for="album-name">Album Name</label>
  <input type="text" name="song[album]" value="<%= @song.album %>" id="album-name"><br>
  <label for="genre-name">Genre Name</label>
  <input type="text" name="song[genre]" value="<%= @song.genre %>" id="genre-name"><br>
  <label for="song-length">Song Length</label>
  <input type="text" name="song[length]" value="<%= @song.length %>" id="song-length"><br>

  <button type="submit">Save Changes</button>
</form>
    ```

- Now the first test should be passing!

### Fixing the Second Error
- Now we're getting the following error: `changes artist and saves changes (FAILED - 1)`
    
    ```ruby
    Failure/Error: expect(page).to have_content 'Nirvana'
       expected to find text "Nirvana" in "Sinatra doesn’t know this ditty. Try this: # in app.rb class App post '/songs/1' do \"Hello World\" end end"
    ```

- Let's add in a method in `app.rb` to catch our post request:

    ```ruby
    post '/songs/:id' do
      ...
    end
    ```

- Now we're hitting our `post` method, but it's not actually doing anything. Why is this? We actually haven't put any DSL logic into our method, so let's do that now.
    
    ```ruby
    post '/songs/:id' do
      @song = Song.find(params[:id])
      @song.update(params[song])
      redirect "/songs/#{@song.id}"
    end
    ```

- Now our second test should pass at this point.

### Using Patch instead of Post

How can we use the `patch` HTTP verb instead of `post`? Currently Sinatra doesn't have support for the patch method, but we can override Rack to allow for this. Look at [this](http://www.sinatrarb.com/configuration.html), and then find the section about `Rack::MethodOverride`.

Let's add this to the top line of our form: `<input type="hidden" name="_method" value="PATCH"/>`.

Then we can change the `post` verb in `app.rb` to `patch`. Finally, let's add `use Rack::MethodOverride` to our `config.ru`.

Now your tests should be passing again.
