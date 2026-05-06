require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.53.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5dfbcca60f0b38ef01e7df644d36384f109ed9ca7cb09c94f71bdc93f7a9f9f',
     armv7l: 'a5dfbcca60f0b38ef01e7df644d36384f109ed9ca7cb09c94f71bdc93f7a9f9f',
       i686: '6d1208e0a0c1eea69e9357652acd1052eb76b5d9bc948df10cc46717438a61d3',
     x86_64: 'f649cdc852be03ed6891a66d20274fc8bc31349caad0caa23173346912551ad7'
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
