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
    aarch64: 'a484aaf139cc8303990585d9210a26ea2b082d08ef509b4b43c47fa4017fe864',
     armv7l: 'a484aaf139cc8303990585d9210a26ea2b082d08ef509b4b43c47fa4017fe864',
       i686: '92798523cb02b9bac85c3b50551a46add00ad29fd97c5e1200b66b3dc6b4d9d8',
     x86_64: 'b79aa316fda1d7ddabdf4985abb1591a7345b1f95ac5e37f31ba07d102c23956'
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
