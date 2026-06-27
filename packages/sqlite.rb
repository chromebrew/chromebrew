require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.53.3'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ef95626b603791b3986740e7ea6ebe7a9fef79843b745ceebdc679cf55e7571',
     armv7l: '7ef95626b603791b3986740e7ea6ebe7a9fef79843b745ceebdc679cf55e7571',
       i686: 'b104c8f6d769ed7d123acef05028df3a84de47935a8c68a312233fae4eb01f62',
     x86_64: '081e9a2b68552a499351f145c37bd955acdebd9044e3548f9169b0c81e70b6a9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :build
  depends_on 'zlib' => :library

  autotools_configure_options '--enable-rtree \
    --enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-fts4 \
    --enable-fts5 \
    --enable-session'
end
