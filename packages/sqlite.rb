require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.45.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2024/sqlite-autoconf-3450000.tar.gz'
  source_sha256 '72887d57a1d8f89f52be38ef84a6353ce8c3ed55ada7864eb944abd9a495e436'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.45.0_armv7l/sqlite-3.45.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.45.0_armv7l/sqlite-3.45.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.45.0_i686/sqlite-3.45.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.45.0_x86_64/sqlite-3.45.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fdbec9d8fda19b985161c1c25ce5db5eeee13bca212e65d2be3e833019dd6bd1',
     armv7l: 'fdbec9d8fda19b985161c1c25ce5db5eeee13bca212e65d2be3e833019dd6bd1',
       i686: '41ee7e8f137657cbdd22892c3da85ab29bb7a2c355daa3ed959a80fc8997a13b',
     x86_64: 'd1af6f403b57fecea4b6aab1e36570ba3499b2f845820ce6ab890ffa8a0ad025'
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
