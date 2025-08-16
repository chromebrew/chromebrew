require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.50.4'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10f50d87e94ec38e2018d0917eb2bc5b3bd75933ca4175f8d064aa2a475075ac',
     armv7l: '10f50d87e94ec38e2018d0917eb2bc5b3bd75933ca4175f8d064aa2a475075ac',
       i686: 'e7c1926beebf60f1828646fe2871a797f7f9f81e71d0b47457d9b298997d8e14',
     x86_64: '005d26149d7352d7de69abfd9a78d3d2ff3eaf22fd313127220d89e256f4e9b8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'ncurses' # R
  depends_on 'readline' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-session'
end
