require 'package'

class Mongodb < Package
  description 'MongoDB is the next-generation database that lets you create applications never before possible.'
  homepage 'https://www.mongodb.com/'
  version '3.0.8'
  binary_url ({
    i686: 'https://www.dropbox.com/s/n32v3h34jswxhg7/mongodb-linux-i686-3.0.8.tar.gz?dl=0',
    x86_64: 'https://www.dropbox.com/s/two0chqyim5eo4a/mongodb-linux-x86_64-3.0.8.tar.gz?dl=0'
  })
  binary_sha256 ({
    i686: 'e4b837c7213d08b528c675710dbd3fb3d5cf761929d0d89d27232fe7609549a3',
    x86_64: '0cacc59ab09d7031ebafc3ff008ff2e9305d9fafc590f1a0e52848342033197a'
  })
end
