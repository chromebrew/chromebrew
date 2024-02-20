require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.45.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2024/sqlite-autoconf-3450100.tar.gz'
  source_sha256 'cd9c27841b7a5932c9897651e20b86c701dd740556989b01ca596fcfa3d49a0a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '526e7c385ebe6e804c8b48a29310deedd2b22cc37f2195403d2ab1390b7bb6f6',
     armv7l: '526e7c385ebe6e804c8b48a29310deedd2b22cc37f2195403d2ab1390b7bb6f6',
       i686: '32020be324aab56b6f392db58d08d1e0f40649b935a3d27a58d7e9c1e5353771',
     x86_64: 'f9eca69789ee02ac577a6b76c3af436a160a76f5f96f796e9f825f156d04516e'
  })

  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'readline' => :build
  depends_on 'zlibpkg' # R
  depends_on 'ncurses' # R

  configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-session \
    --with-pic'
end
