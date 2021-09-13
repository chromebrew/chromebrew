require 'package'

class Freebasic < Package
  description 'FreeBASIC is a free and open source, BASIC compiler for Microsoft Windows, DOS and Linux.'
  homepage 'https://www.freebasic.net/'
  version '1.08.1'
  license 'LGPL-2 and GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.08.1/Binaries-Linux/FreeBASIC-1.08.1-linux-arm.tar.xz'
    source_sha256 'e321b8bec63446c9891db4df2d2e4d08552f3ca030def416a208f851367bee8c'
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.08.1/Binaries-Linux/FreeBASIC-1.08.1-linux-x86.tar.xz'
    source_sha256 '8f11af664858e29d0798e19aa895c0439f14a9660eba04c7fe4c872c98132524'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.08.1/Binaries-Linux/FreeBASIC-1.08.1-linux-x86_64.tar.xz'
    source_sha256 'f32213b2efb0be2799995cab0de429ce862ae2f9b36af4e236948985c20583c7'
  end

  depends_on 'libtinfo'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    system "./install.sh -i #{CREW_DEST_PREFIX}"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", "#{CREW_DEST_PREFIX}/share"
  end

  def self.postinstall
    puts "\nType 'fbc' to get started.\n".lightblue
  end
end
