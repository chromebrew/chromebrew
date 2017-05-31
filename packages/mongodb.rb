require 'package'

class Mongodb < Package
  description 'MongoDB is the next-generation database that lets you create applications never before possible.'
  homepage 'https://www.mongodb.com/'
  version '3.0.8'
  binary_url ({
    i686: "https://www.dropbox.com/s/n32v3h34jswxhg7/mongodb-linux-i686-3.0.8.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/two0chqyim5eo4a/mongodb-linux-x86_64-3.0.8.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "71fd4324ce91352416eea83149432b953928306e",
    x86_64: "fdbf8ad9207dc5fd31af0113e9c00e02521e9101"
  })
end