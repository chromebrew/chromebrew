# Adapted from Arch Linux gpp PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gpp

require 'buildsystems/autotools'

class Gpp < Autotools
  description 'A general-purpose preprocessor with customizable syntax, suitable for a wide range of preprocessing tasks'
  homepage 'https://github.com/logological/gpp'
  version '2.28'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://github.com/logological/gpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ceba12373c704072aef012bd21eade007d18684189c9502237787a812275b66',
     armv7l: '5ceba12373c704072aef012bd21eade007d18684189c9502237787a812275b66',
     i686: '260086851f61b4a1ddf8b23006f1c8b54d8e5a865f476a0d0e7767fc9a9a88d1',
     x86_64: '8cd458b699e28dbf250fb0bf39fbeef47748c1d6738894a0b3957b5bc66981db'
  })

  depends_on 'glibc' # R
end
