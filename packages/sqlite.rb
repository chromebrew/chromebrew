require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.41.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://sqlite.org/2023/sqlite-autoconf-3410000.tar.gz'
  source_sha256 '49f77ac53fd9aa5d7395f2499cb816410e5621984a121b858ccca05310b05c70'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.0_armv7l/sqlite-3.41.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.0_armv7l/sqlite-3.41.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.0_i686/sqlite-3.41.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.0_x86_64/sqlite-3.41.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1f5e54895fbabccab623c57fa46e69ab3a572eab48c7a0bc31b2f74250f545e5',
     armv7l: '1f5e54895fbabccab623c57fa46e69ab3a572eab48c7a0bc31b2f74250f545e5',
       i686: 'f7fdf39fe062ba935843035c196ab2527ae2fb517b3699e22ba4c0afe5547084',
     x86_64: 'dabc034321db0bd620ef5aa0f91a2ad8356e21671268494ca876e035a817ee75'
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
