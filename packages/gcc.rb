require 'package'

class Gcc < Package
  version '4.8.1-baseline'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/c06pcge8ogsqfcd/gcc-4.8.1-baseline-chromeos-i686.tar.gz?token_hash=AAFLnE_8iL_lAnGtAAVM5G_sYqejA44jGW8D9r0a8xCjrQ&dl=1"
  })
  binary_sha1 ({
    i686: "d720c9a804d26728d730b93748072ffa6df7ee3d"
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpc'
  depends_on 'mpfr'
  depends_on 'glibc'
end
