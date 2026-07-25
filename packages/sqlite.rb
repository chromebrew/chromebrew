require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.53.4'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba88e02fbfa9b34176e2574edc9fe7a2b4c7acdf1486939cd3599e9b9034bb55',
     armv7l: 'ba88e02fbfa9b34176e2574edc9fe7a2b4c7acdf1486939cd3599e9b9034bb55',
       i686: 'd815354ada1896cbe0785d7cc754e7adcf386c32bf4f01fcb72bbcc1521f84ce',
     x86_64: 'ffa4ddd942d7c405a00ebaf65bf090fa7f724e169cfb253d0c479dafa42ed402'
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
