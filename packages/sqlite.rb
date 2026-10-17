require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.54.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7c91893ae3647a0b12e8eb662091f40b00749d10f0de44a34397b138dc562a8',
     armv7l: 'c7c91893ae3647a0b12e8eb662091f40b00749d10f0de44a34397b138dc562a8',
       i686: '9441243284bf7b83bc121d812425ac3c0529d821a5bdeec99ef08f191ca5698b',
     x86_64: '9b94d024df481f81a3e85268eec47e4af369cce690e6764e13958a8497e3f377'
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
