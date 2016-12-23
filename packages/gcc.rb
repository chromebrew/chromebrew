require 'package'

class Gcc < Package
  version '4.8.1-baseline'

  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/jymjldw7wbumadw/gcc-4.9.2-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/c06pcge8ogsqfcd/gcc-4.8.1-baseline-chromeos-i686.tar.gz?token_hash=AAFLnE_8iL_lAnGtAAVM5G_sYqejA44jGW8D9r0a8xCjrQ&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/kk52ic170je87fc/gcc-4.8.1-baseline-chromeos-x86_64.tar.gz?token_hash=AAGcQBSj1y8OfHXUhsayxlFfvk4LRszY07ehx_Z6UoyNEg&dl=1"
  })
  binary_sha1 ({
    armv7l: "3fe46ef306db8777e8282de1681c121c7058f590",
    i686: "d720c9a804d26728d730b93748072ffa6df7ee3d",
    x86_64: "59932a73cd149ae82b4b5c277b734788c1efab44"
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpc'
  depends_on 'mpfr'
  depends_on 'glibc'
end
