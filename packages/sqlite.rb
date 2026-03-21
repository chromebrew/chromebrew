require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.52.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c37f97a19fc73f1441e140df616978db8ed351873a98a3c37caa68072742429a',
     armv7l: 'c37f97a19fc73f1441e140df616978db8ed351873a98a3c37caa68072742429a',
       i686: '84f206a7e2567c2d2fa470a2a758b29b30a4ed95036d20624236ea8214276a98',
     x86_64: '2715da2b2e9ff464a6f49ad76c8634003e7b3d38deb8890bc0ad82260c107429'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'libedit' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :build
  depends_on 'zlib' => :library

  autotools_configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-fts4 \
    --enable-fts5 \
    --enable-session'
end
