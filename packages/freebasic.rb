require 'package'

class Freebasic < Package
  description 'FreeBASIC is a free and open source, BASIC compiler for Microsoft Windows, DOS and Linux.'
  homepage 'https://www.freebasic.net/'
  version '1.09.0'
  license 'LGPL-2 and GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.09.0/Binaries-Linux/FreeBASIC-1.09.0-linux-arm.tar.xz'
    source_sha256 '7e75720f3f1b706a8d0d99d0fefbfffcf08305b7801083443c2aa58f4bc8a41e'
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.09.0/Binaries-Linux/FreeBASIC-1.09.0-linux-x86.tar.xz'
    source_sha256 'fcbfa40d8b7fbab866fd2ece9813e50c1177ba3f7e8cf746bfef1412a6f0dac1'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/fbc/FreeBASIC-1.09.0/Binaries-Linux/FreeBASIC-1.09.0-linux-x86_64.tar.xz'
    source_sha256 'c8143b1207541ddcdf8d5d87f36a85a8bf6fdf85b3e6aee56323a0ecdacbc1e5'
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
