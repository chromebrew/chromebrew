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
  binary_sha256 ({
    armv7l: "b7fab53d3c8cfd42d41c1b07db069c9fd5f7261fcea48fd99114981cf1a293d7",
    i686: "1e73fbff3a10c0c95dd1aa1cf68952a95a330634fa410765962df0396315a42c",
    x86_64: "9259cd8b5d7aaeb9172142b5956ad767a3d4f1bcf126e51a7f4a8c055e53c068"
  })
end
