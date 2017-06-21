require 'package'

class Dart < Package
  version '1.22.0'

  binary_url ({
    armv7l: "https://www.dropbox.com/s/3w9kvs3yross3lw/dart-1.22.0-arm.tgz",
    i686: "https://www.dropbox.com/s/p3ib8qx32j70qwi/dart-1.22.0-ia32.tgz",
    x86_64: "https://www.dropbox.com/s/i8r0kzqd5r7iunz/dart-1.22.0-x64.tgz"
  })
  binary_sha1 ({
    armv7l: "7d8d9cb9e92d72853eb7c536fd5af6183973958d",
    i686: "0dc1c5de8f0802ff64ba111d60432191d8e852de",
    x86_64: "472c6364d4afac21337fcd89c3001c04fa63bb4d"
  })
end
