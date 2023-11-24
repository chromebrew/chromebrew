require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.44.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3440100.tar.gz'
  source_sha256 '63c3181633844adb5e36187f75b8f31a51cd32487992a26b89bf26b22ecdcf48'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.1_armv7l/sqlite-3.44.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.1_armv7l/sqlite-3.44.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.1_i686/sqlite-3.44.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.1_x86_64/sqlite-3.44.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'db8b53e1d8abc507ccb7e3cd852492c04a8d97837957ab8d2f48d037b17dfaca',
     armv7l: 'db8b53e1d8abc507ccb7e3cd852492c04a8d97837957ab8d2f48d037b17dfaca',
       i686: '758eb5257fbe2ad773fed7ea04118d0702c3d1735f5c93567c78e3a851048db4',
     x86_64: 'b44c5378735a86930dd088b3e120462be4d776935b8a22d97845c0796ddb7f35'
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
