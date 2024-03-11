require 'package'

class Dosbox < Package
  description 'DOSBox is a DOS-emulator that uses the SDL-library'
  homepage 'https://www.dosbox.com/'
  version '0.74-3'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/dosbox/dosbox/0.74-3/dosbox-0.74-3.tar.gz'
  source_sha256 'c0d13dd7ed2ed363b68de615475781e891cd582e8162b5c3669137502222260a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '4d63eeba4d2e93696ff90cf61f806ea64b86552a7739651a6b717427e9ebe94f',
     armv7l: '4d63eeba4d2e93696ff90cf61f806ea64b86552a7739651a6b717427e9ebe94f',
     x86_64: '1e45f3a2ef42431b06cc98f4c3769f8f1ce65094d71b0a9ff871eaabb6f22e86'
  })

  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "Type 'dosbox' to get started.".lightblue
    puts
  end

  def self.remove
    print 'Would you like to remove the config directory? [y/N] '
    response = $stdin.gets.chomp.downcase
    config_dir = "#{HOME}/.dosbox"
    if Dir.exist? config_dir
      case response
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
