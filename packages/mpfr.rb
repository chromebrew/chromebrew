require 'package'

class Mpfr < Package
  version '3.1.5'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/gqd8pzck4p7nl1k/mpfr-3.1.5-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/xiw4vjtew4zujmd/mpfr-3.1.5-chromeos-i686.tar.xz",
    x86_64: "https://dl.dropboxusercontent.com/s/n8ygddm4ir8ihbg/mpfr-3.1.5-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "8ace66e438f6593affc460cc8a45f2a7df0ac1ca",
    i686: "1a3e4833cbdf002e5fd62135b5113c37c2700362",
    x86_64: "0028523daf1b3935bad21d3706e39fb248a8f0f2",
  })
end
