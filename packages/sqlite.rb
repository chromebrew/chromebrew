require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.49.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2025/sqlite-autoconf-3490000.tar.gz'
  source_sha256 '4d8bfa0b55e36951f6e5a9fb8c99f3b58990ab785c57b4f84f37d163a0672759'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02ac3e9b356a5f0e8285571ec3234a1158dad2be2073356e39b7febada545644',
     armv7l: '02ac3e9b356a5f0e8285571ec3234a1158dad2be2073356e39b7febada545644',
       i686: 'db23ab9115398bef425478b3ef43dee260ced68bb964d4cfe0bd70e9d886a0fb',
     x86_64: '657df8ae9a5aa6ef321e2f677ffa92fced56d45c313d63b0b15bbd158615347d'
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
    --enable-session'
end
