require 'package'

class Binutils < Package
  version '2.25'
  binary_url ({
    armv7l: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-chromeos-armv7l.tar.xz",
    i686: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-chromeos-i686.tar.xz",
    x86_64: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "d4b42e13b4e4ed87c0f7a449b067b5f42345b7d8",
    i686: "bc686fd29b9e9588a6f4f37c619dba217afb9bc3",
    x86_64: "3ca5e6940c47385456f96861b169f925543f08b3",
  })
end
