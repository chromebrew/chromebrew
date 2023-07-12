require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.0.9-1'
  license 'Unknown, BSD-3-Clause'
  compatibility 'all'
  source_url 'https://github.com/arvidn/libtorrent/releases/download/v2.0.9/libtorrent-rasterbar-2.0.9.tar.gz'
  source_sha256 '90cd92b6061c5b664840c3d5e151d43fedb24f5b2b24e14425ffbb884ef1798e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9-1_armv7l/libtorrent-2.0.9-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9-1_armv7l/libtorrent-2.0.9-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9-1_i686/libtorrent-2.0.9-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9-1_x86_64/libtorrent-2.0.9-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3cb2ebed40910fc51e140ba44958877ac14363fcbdc71ddaa97e15ee76b3128b',
     armv7l: '3cb2ebed40910fc51e140ba44958877ac14363fcbdc71ddaa97e15ee76b3128b',
       i686: '945b87b3f97f19da0a81a2562e96ea2fcf55eddaf53c3aa2ecddd4be12efbb99',
     x86_64: 'ccde87bd39b059c4ed710a3a4e905ebf43419e097cd326356f4b8d386619eed6'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
