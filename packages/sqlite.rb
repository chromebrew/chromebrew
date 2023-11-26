require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.44.2'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3440200.tar.gz'
  source_sha256 '1c6719a148bc41cf0f2bbbe3926d7ce3f5ca09d878f1246fcc20767b175bb407'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.2_armv7l/sqlite-3.44.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.2_armv7l/sqlite-3.44.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.2_i686/sqlite-3.44.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.2_x86_64/sqlite-3.44.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e80bbe42334e91c71090008328b4586295b974c5f155c78696d8186d98d6c953',
     armv7l: 'e80bbe42334e91c71090008328b4586295b974c5f155c78696d8186d98d6c953',
       i686: 'c5c223eec3c8993c2a016a60f47b3d1f103ffca53dba5f0541b18cae9d195d9a',
     x86_64: 'ff9d2c375aff691f267a0ca185868c1a75ffeb7ae9a2744388f6499b1cc49cae'
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
