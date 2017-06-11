require 'package'

class Cloog < Package
  description 'Chunky Loop Generator which is used to perform optimization in gcc'
  homepage 'https://www.cloog.org/'
  version '0.18.4-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'f4a3af2c427944f30b4149428af1215a0200ff57',
    armv7l:  'f4a3af2c427944f30b4149428af1215a0200ff57',
    i686:    'fa62fb428bb6d211c6896bbb9912caa170db0590',
    x86_64:  '5ffdb93347874dbd06916a50cba7876299f29ba2',
  })
end
