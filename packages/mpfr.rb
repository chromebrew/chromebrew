require 'package'

class Mpfr < Package
  version '3.1.2'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/56np7jwgybpcel8/mpfr-3.1.2-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/lo9ks3g7ar3zpfu/mpfr-3.1.2-chromeos-i686.tar.gz?token_hash=AAH1GlLfYtUs4uxl1ayeGTBe8RJ5uTXzOAsXgSlv8G5rrA&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/ev2a1yha3gm1hwy/mpfr-3.1.2-chromeos-x86_64.tar.gz?token_hash=AAErYQPCHkhALqnX4Y0LjATZITtD2qoKNbkdn67LOmRVRQ&dl=1"
  })
  binary_sha1 ({
    armv7l: "cad1a1d66f52199733d84638b7cb4178069efdb9",
    i686: "eb81b9bb83ebb43b94ab33e43293f1df3bcbad7c",
    x86_64: "a80c48bee7e6e8ddcd1771c4fd7708d89f2abb9c"
  })
end
