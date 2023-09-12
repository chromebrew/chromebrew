require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.43.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3430101.tar.gz'
  source_sha256 '098984eb36a684c90bc01c0eb7bda3273c327cbc3673d7d0bc195028c19fb7b0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.1_armv7l/sqlite-3.43.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.1_armv7l/sqlite-3.43.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.1_i686/sqlite-3.43.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.1_x86_64/sqlite-3.43.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35cdc827104dacfdac2a39b603a41786c1acb87c23a3b8b5b7ccfee6fd1fb24b',
     armv7l: '35cdc827104dacfdac2a39b603a41786c1acb87c23a3b8b5b7ccfee6fd1fb24b',
       i686: '655d4d13ca2daa54bd6c08456ad151da1aec53b836951fb8b13d198dcae2de3e',
     x86_64: 'c75259d9f0217eaf2946bff7250d754513eca191f4e8cbb0675b1a5537463c78'
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
