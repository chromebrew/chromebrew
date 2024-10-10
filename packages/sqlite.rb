require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.46.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2024/sqlite-autoconf-3460100.tar.gz'
  source_sha256 '67d3fe6d268e6eaddcae3727fce58fcc8e9c53869bdd07a0c61e38ddf2965071'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77a65e449b58fed33e40d6a414f2c863ca9c5023d5c07f0c121f8bcb38198fe0',
     armv7l: '77a65e449b58fed33e40d6a414f2c863ca9c5023d5c07f0c121f8bcb38198fe0',
       i686: '1e0ecb9e4edfc496e7d55949af6ae6d27fa584b55d94adf7fd7fa2295f5814d9',
     x86_64: '59870ca8524fed61744a8dd818714bd54af3d3731fc6ef8a9f28ffc0833a85bf'
  })

  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'readline' => :build
  depends_on 'zlib' # R
  depends_on 'ncurses' # R

  configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-session \
    --with-pic'
end
