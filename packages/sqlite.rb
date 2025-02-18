require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.49.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2025/sqlite-autoconf-3490100.tar.gz'
  source_sha256 '4d8bfa0b55e36951f6e5a9fb8c99f3b58990ab785c57b4f84f37d163a0672759'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a6911c8e0c6d8d794b5cad139032fe7f01231d20640096795cf48cae756863b',
     armv7l: '9a6911c8e0c6d8d794b5cad139032fe7f01231d20640096795cf48cae756863b',
       i686: '6bf47640b80c571abde63d0fd2a9b5c45b5e39ae9e6c597ae87204cd15837c4a',
     x86_64: 'b18d0d0064c133916cc41a90b0fc4da199c513a79e296ece6b72dbda53ff23fd'
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
