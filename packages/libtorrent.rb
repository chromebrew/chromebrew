require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.0.10'
  license 'Unknown, BSD-3-Clause'
  compatibility 'all'
  source_url "https://github.com/arvidn/libtorrent/releases/download/v#{version}/libtorrent-rasterbar-#{version}.tar.gz"
  source_sha256 '90cd92b6061c5b664840c3d5e151d43fedb24f5b2b24e14425ffbb884ef1798e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf3e30dd7fffa4a538d2d33ddc58fe939fb0bf09a483c0dbc1294f2c5aad49e3',
     armv7l: 'cf3e30dd7fffa4a538d2d33ddc58fe939fb0bf09a483c0dbc1294f2c5aad49e3',
       i686: '1c7df2be1186aa7d946fe462cebe6f1176ee15f907bd51ed681bfa95daf29546',
     x86_64: '1b9aa2111346efb2f6fcdbcbecd5d1e01ede2c571c16cd4f36f72cb228099fe5'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
