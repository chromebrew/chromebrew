require 'package'
require 'json'
require 'fileutils'

class Wine < Package
  version '2.8'
  source_url 'https://dl.winehq.org/wine/source/2.x/wine-2.8.tar.xz'
  source_sha1 'a36d2afb572a3cfb160066373cb78ea0506b9dfd'

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
