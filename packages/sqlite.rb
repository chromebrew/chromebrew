require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.47.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2024/sqlite-autoconf-3470000.tar.gz'
  source_sha256 '83eb21a6f6a649f506df8bd3aab85a08f7556ceed5dbd8dea743ea003fc3a957'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9386244b031d7c5b599a4648e51b4e2db0c2372f7202b2bdc136fc9d8ef4729',
     armv7l: 'f9386244b031d7c5b599a4648e51b4e2db0c2372f7202b2bdc136fc9d8ef4729',
       i686: 'b8570b4db49c9800368d758646150058fa0cbe90445709c38b5d07d16d71df69',
     x86_64: '3354d21d2349da58f29447574ea8ac44280907c6f1476a785f3afec4914a0e03'
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
