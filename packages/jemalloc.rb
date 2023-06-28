require 'buildsystems/autotools'

class Jemalloc < Autotools
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.3.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2'
  source_sha256 '2db82d1e7119df3e71b7640219b6dfe84789bc0537983c3b7ac4f7189aecfeaa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jemalloc/5.3.0_armv7l/jemalloc-5.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jemalloc/5.3.0_armv7l/jemalloc-5.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jemalloc/5.3.0_i686/jemalloc-5.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jemalloc/5.3.0_x86_64/jemalloc-5.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9484d742bccf179955042cf64e600264da004e3dca493ea3c62138398a0923c5',
     armv7l: '9484d742bccf179955042cf64e600264da004e3dca493ea3c62138398a0923c5',
       i686: 'c024f394bc1964745453c0f4cfbd845567c26e8bb3b1d373d3ffe02cca6c5b42',
     x86_64: '18fcc5b3f4412293a0f72723bbebcba5571750691a6e5ca6f5db8a7a146d5b4c'
  })

  depends_on 'libxslt' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
