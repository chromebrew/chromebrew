require 'package'

class Cloog < Package
  version "0.18.4"
  binary_url ({
    armv7l: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/cloog-0.18.4-chromeos-armv7l.tar.xz",
    i686: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/cloog-0.18.4-chromeos-i686.tar.xz",
    x86_64: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/cloog-0.18.4-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "919798d4329b96aa33374fe460d95e6e485b00c2",
    i686: "7f37371de5d5f7eeaf13fe93fc664ecd6daadb25",
    x86_64: "33d18076f6ca5b5c56e7908368b87d137355696a",
  })
end
