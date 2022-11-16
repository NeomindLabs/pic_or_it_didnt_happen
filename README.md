# Pics Or It Didn't Happen
###### A Ruby gem that lets you include images in HTML using data URLs (and avoid serving the image file separatly). 

***
_This gem is a fork of [Megan Ruggiero](https://github.com/decadentsoup)'s [DataURL gem](https://github.com/decadentsoup/dataurl)._
***

Sometimes, you might want your HTML to include a one-off image file that is just for one person. Making this file public may be undesireable for security reasons, or perhaps simply because it is not worth the overhead of multiple HTTP requests.

This gem provides a utility method that takes a locally-saved image file, perhaps within your non-public `tmp` directory, encodes it as Base64, and returns an HTML `<img>` element with the correct [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs) attributes. 

It is made possible by the [RFC 2397](https://datatracker.ietf.org/doc/html/rfc2397) scheme, which is now [fairly well supported](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs#browser_compatibility) in modern browsers.

Here is an example ([from this fiddle](http://jsfiddle.net/hpP45/)) of an `<img>` tag with the image data saved within the HTML itself:
```html
<img 
  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" 
  alt="Red dot" 
/>
```
[This example HTML page](https://htmlpreview.github.io/?https://github.com/NeomindLabs/pics_or_it_didnt_happen/blob/master/example_red_dot.html) will show you how this renders in a browser. You should see a small red dot in the top left corner.


#### Getting Started
Run
```shell
gem install pics_or_it_didnt_happen
```
or add
```ruby
gem 'pics_or_it_didnt_happen'
```
to your `Gemfile`.

#### The `image_to_data_url_image_tag` Method
This method takes a file path to an image file (GIF, PNG or JPG) as an argument, and returns an `img` tag with the image encoded as a data URL:
```ruby
PicsOrItDidntHappen.image_to_data_url_image_tag('path/to/your/image.png')
=> "<img src="data:image/png;base64,ALOTOFBASE64ENCODEDDATAHERE"/>"
```
You can also pass alt text like this:
```ruby
PicsOrItDidntHappen.image_to_data_url_image_tag('path/to/your/image.png', alt_text: 'a great image')
=> "<img src="data:image/png;base64,ALOTOFBASE64ENCODEDDATAHERE" alt="a great image"/>"
```

#### Contributions
Pull requests welcome! 

#### Licence
This gem uses the MIT licence. See `licence.txt` for details.