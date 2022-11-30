require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.40.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://sqlite.org/2022/sqlite-autoconf-3400000.tar.gz'
  source_sha256 '0333552076d2700c75352256e91c78bf5cd62491589ba0c69aed0a81868980e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.40.0_armv7l/sqlite-3.40.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.40.0_armv7l/sqlite-3.40.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.40.0_i686/sqlite-3.40.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.40.0_x86_64/sqlite-3.40.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7321acc0fc9acdccdb730e541137d94c48eaf812760dd57d00eeab173dd14b7d',
     armv7l: '7321acc0fc9acdccdb730e541137d94c48eaf812760dd57d00eeab173dd14b7d',
       i686: '6d0b2fa7871e0eed3f82cb3310ce9b3d3444b53d67366f827656df3c57539b1b',
     x86_64: '7e9322ba98d584cab05c372894d2f0204ea696624ddfc9694cf128810ae66c70'
  })

  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'readline' => :build
  depends_on 'zlibpkg' # R
  depends_on 'ncurses' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --enable-shared \
      --enable-editline \
      --enable-readline \
      --enable-fts5 \
      --enable-json1 \
      --enable-session \
      --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
