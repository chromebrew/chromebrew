require 'package'

class Gmp < Package
  version "6.1.2"
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/lsysc6fka01fdb9/gmp-6.1.2-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/skficanyik0fo4q/gmp-6.1.2-chromeos-i686.tar.xz",
    x86_64: "https://dl.dropboxusercontent.com/s/dnfc1eqnqx6qg1m/gmp-6.1.2-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "ef330045d0eb7b33015e31cd1ac8428caacaf026",
    i686: "a26eeac034966b50ca70d43b23768a078ca4dd14",
    x86_64: "0ada7fbc26b2b5567df516daaf61edc4129ae1b5",
  })
end
