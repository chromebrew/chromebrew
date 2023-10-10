require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.43.2'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3430200.tar.gz'
  source_sha256 '6d422b6f62c4de2ca80d61860e3a3fb693554d2f75bb1aaca743ccc4d6f609f0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.2_armv7l/sqlite-3.43.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.2_armv7l/sqlite-3.43.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.2_i686/sqlite-3.43.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.43.2_x86_64/sqlite-3.43.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1a99b74561be8bf838eb7d3d8834aa15fb44fd46b7b759736e0715fbedd7e10f',
     armv7l: '1a99b74561be8bf838eb7d3d8834aa15fb44fd46b7b759736e0715fbedd7e10f',
       i686: 'b03bb82a74146c0a461732f182c86a4d791aa61975fb90ad12ec6995362f3649',
     x86_64: '71de21137d8b14dc47f8c53520b297e91b67f3d1528264212c3f0af69a3590a6'
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
