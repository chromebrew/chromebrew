require 'buildsystems/autotools'

class Jemalloc < Autotools
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.3.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/jemalloc/jemalloc/releases/download/#{version}/jemalloc-#{version}.tar.bz2"
  source_sha256 '3826bc80232f22ed5c4662f3034f799ca316e819103bdc7bb99018a421706f92'
  binary_compression 'tar.zst'

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
