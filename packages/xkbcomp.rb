require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.4'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/app/xkbcomp-1.4.4.tar.bz2'
  source_sha256 '59cce603a607a17722a0a1cf99010f4894e7812beb5d695abbc08474d59af27e'


  depends_on 'mesa'
  depends_on 'xcb_util'
    
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    puts
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
    puts
  end
end
