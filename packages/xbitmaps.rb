require 'buildsystems/autotools'

class Xbitmaps < Autotools
  description 'The xbitmaps package contains bitmap images used by multiple applications built in Xorg chapter.'
  homepage 'https://www.x.org/wiki/'
  version '1.1.3'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.x.org/pub/individual/data/xbitmaps-#{version}.tar.bz2"
  source_sha256 '3671b034356bbc4d32d052808cf646c940ec8b2d1913adac51b1453e41aa1e9d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f593f78a6db4cf69e97da6a07e954971a8623164799161bca5fd7e717085720d',
     armv7l: 'f593f78a6db4cf69e97da6a07e954971a8623164799161bca5fd7e717085720d',
       i686: 'c02b3e780b87551954cf975020a5065a8277f935f769b5d56fe80b8ccfd8b50d',
     x86_64: '161b342836f77df11606c5fa965b38912022d108569313d504a0bc5d1bce4c16'
  })

  depends_on 'xorg_macros' => :build
end
