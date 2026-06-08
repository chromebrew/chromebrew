require 'package'

class Hdparm < Package
  description 'hdparm is a GNU/Linux shell utility for viewing and manipulating various IDE drive and driver parameters.'
  homepage 'https://directory.fsf.org/wiki/Hdparm'
  version '9.65'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/hdparm/hdparm/hdparm-#{version}.tar.gz"
  source_sha256 'd14929f910d060932e717e9382425d47c2e7144235a53713d55a94f7de535a4b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23f018926ee1d887b6aab0b2c4d90dcc8df16a081daeebc49e41d0a279bad46d',
     armv7l: '23f018926ee1d887b6aab0b2c4d90dcc8df16a081daeebc49e41d0a279bad46d',
       i686: '725a35873d65a5c43bff13bffd7216488b64cf835b82669187f62a37fa658f3d',
     x86_64: 'eff15bef5a29e1fde9fcdd4154f970c475d850b326b41be6d105517fb9264faa'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's,binprefix = ,binprefix = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,manprefix = /usr,manprefix = #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", '-e', 'install'
  end
end
