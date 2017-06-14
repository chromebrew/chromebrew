require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '4.28.3'
  binary_url ({
    armv7l: "https://drive.google.com/uc?export=download&id=0ByCixsDmZPzxOHFIMzQyNHNFUWc",
    i686: "https://drive.google.com/uc?export=download&id=0ByCixsDmZPzxd3NULTRkMWlHQTA",
    x86_64: "https://drive.google.com/uc?export=download&id=0ByCixsDmZPzxLURkMktpREpDZk0"
  })
  binary_sha1 ({
    armv7l: "b48f2f52d11cee4ca6a1878fdf2608a4b10ea53d",
    i686: "1b0a736797c9293431b7db0055861fc73657a3fe",
    x86_64: "9524fbc86c0a19f84f8bbb77c56ce2439d929a92"
  })
end
