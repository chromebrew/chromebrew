require 'package'
require 'json'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  version '2.10'
  source_url 'https://dl.winehq.org/wine/source/2.x/wine-2.10.tar.xz'
  source_sha1 '886bc24c315b2accbc2ad41d921e92177768f3a5'

  depends_on 'bison'
  depends_on 'flex'
  depends_on 'freetype'

  def self.build
    device = JSON.parse(File.read('/usr/local/etc/crew/device.json'), symbolize_names: true)
    case device[:architecture]
    when "i686" || "armv7l"
      system "./configure --without-x"
    when "x86_64" || "aarch64"
      system "./configure --without-x  --enable-win64"
    else
      puts "Error getting your device configuration."
    end
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
