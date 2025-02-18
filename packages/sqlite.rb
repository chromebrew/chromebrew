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
     x86_64: '94b9135bdefbe38564119db4ff021c1a0bcf83fb367cff9fa884b35974f40d01'
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
