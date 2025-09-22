require 'buildsystems/autotools'

class Libev < Autotools
  description 'High-performance event loop loosely modelled after libevent'
  homepage 'http://software.schmorp.de/pkg/libev.html'
  version '4.33-1'
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url "http://dist.schmorp.de/libev/libev-#{version.split('-').first}.tar.gz"
  source_sha256 '507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a92780957f22e1bf258fef67d14853fbaab5a5dc8277c31427858713a5f8dca',
     armv7l: '2a92780957f22e1bf258fef67d14853fbaab5a5dc8277c31427858713a5f8dca',
       i686: '152853c45d79d0391ff45c9784994997b91ea733d1f014eb9d21bd7bd3e6b95e',
     x86_64: 'c8176dfc182d24c1a0fa9146cd3e8db22210fbb50ab58885843e59f5421cdfe2'
  })

  depends_on 'glibc' # R
end
