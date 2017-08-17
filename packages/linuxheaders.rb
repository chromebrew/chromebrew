require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage ''
  version '3.18-2'
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/linuxheaders-3.18-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew-cross/linuxheaders-3.18-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew-cross/linuxheaders-3.18-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/linuxheaders-3.18-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '811e1bfa4d83e866ac7625c6970d7289b8768bf30b18af8a3b79c0760dfa42af',
     armv7l: '811e1bfa4d83e866ac7625c6970d7289b8768bf30b18af8a3b79c0760dfa42af',
       i686: '8ee5c68467cb5e7994993cddf163d59cb61a5f7d70f5bc595cb3fe288131ae59',
     x86_64: '830b18e54ebd6a2c8701c5ea1efd883e345719770de34ad0ece2f7cfb904df6f',
  })
end
