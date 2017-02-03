require 'package'

class Isl < Package
  version "0.14.1"
  binary_url ({
    armv7l: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/isl-0.14.1-chromeos-armv7l.tar.xz",
    i686: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/isl-0.14.1-chromeos-i686.tar.xz",
    x86_64: "https://github.com/jam7/chromebrew/releases/download/newtoolchains/isl-0.14.1-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "c151cbe2601eda6cd391da165ad940aa7fa666bc",
    i686: "cc2d07411dbfcfd03afe0953bce8cef8d7bb8307",
    x86_64: "3fa612198955e3d6e8201c05ef486d1462c76462",
  })
end
