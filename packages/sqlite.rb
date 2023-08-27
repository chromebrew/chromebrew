require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.43.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://sqlite.org/2023/sqlite-autoconf-3430000.tar.gz'
  source_sha256 '49008dbf3afc04d4edc8ecfc34e4ead196973034293c997adad2f63f01762ae1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.0_armv7l/sqlite-3.43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.0_armv7l/sqlite-3.43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.0_i686/sqlite-3.43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.0_x86_64/sqlite-3.43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf11bb4199d71b7a72f970de86ed7adca8e4ff93f5b72f2201601f832ecbfc60',
     armv7l: 'bf11bb4199d71b7a72f970de86ed7adca8e4ff93f5b72f2201601f832ecbfc60',
       i686: '8228c3351ddbab9e3b12e4e7cfe6e30215d98d08995b7a212931808962186377',
     x86_64: '3efb7908eeaf2f36993f75db1d2deb4f2c5ad5e7fd68daba7854194e826ffd19'
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
