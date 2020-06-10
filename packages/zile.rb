require 'package'

class Zile < Package
  description 'A small, fast, and powerful Emacs clone'
  homepage 'http://www.gnu.org/software/zile/'
  version '2.4.14'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/zile/zile-2.4.14.tar.gz'
  source_sha256 '7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zile-2.4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zile-2.4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zile-2.4.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zile-2.4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9af8d03f90d5a5f6ffd48774ccdc053ffb8d0a878baf883a301ff709d1d8d2d4',
     armv7l: '9af8d03f90d5a5f6ffd48774ccdc053ffb8d0a878baf883a301ff709d1d8d2d4',
       i686: '24b7a3e4dca4fd149a34ab37d7b7e5f297198edf8264825d65c5406d1c3d1582',
     x86_64: '7acde7380f56dc54d6c74ec5cf7fd9f7ebb666524144d4c1d229ff31e2c66da3',
  })

  depends_on 'bdwgc'
  depends_on 'help2man' => :build

  def self.build
    system './configure',
	   "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
	   "--prefix=#{CREW_PREFIX}",
	   '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
