require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.26'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gdbm/gdbm-#{version}.tar.gz"
  source_sha256 '6a24504a14de4a744103dcb936be976df6fbe88ccff26065e54c1c47946f4a5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '089093bffd085579851130358eb0670438758dd75fcca59fa820c3fcd4c686a1',
     armv7l: '089093bffd085579851130358eb0670438758dd75fcca59fa820c3fcd4c686a1',
       i686: 'e0a4d2b9cb6ed1d9ad0f26045861647d895d84fd7c2e73a1ad9a23977dadf25c',
     x86_64: '253f28e1e424ac6cd8d4cabe39b89297d98390d98aed0a686774b1dd75304f26'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' => :executable_only
  depends_on 'readline' => :executable_only

  def self.build
    system "./configure \
      #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
