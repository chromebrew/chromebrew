require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.42.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://sqlite.org/2023/sqlite-autoconf-3420000.tar.gz'
  source_sha256 '7abcfd161c6e2742ca5c6c0895d1f853c940f203304a0b49da4e1eca5d088ca6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.42.0_armv7l/sqlite-3.42.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.42.0_armv7l/sqlite-3.42.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.42.0_i686/sqlite-3.42.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.42.0_x86_64/sqlite-3.42.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '24ffc972f9e478af82b36403bc65bc898359d80f73f278a11e237e9b9d3a082e',
     armv7l: '24ffc972f9e478af82b36403bc65bc898359d80f73f278a11e237e9b9d3a082e',
       i686: 'e6efb87561075d94a3c00610667356522c9c134a20f6b80b1a17f23a7c4b77ad',
     x86_64: '5438c63114be4541489fc484287a7e6f8cd619b0771d9f5f19b525e619ea4b3d'
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
