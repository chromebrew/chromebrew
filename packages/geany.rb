require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '1.36'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://download.geany.org/geany-1.36.tar.bz2'
    source_sha256 '9184dd3dd40b7b84fca70083284bb9dbf2ee8022bf2be066bdc36592d909d53e'
    depends_on 'gtk3'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.36-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.36-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.36-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e89045825ce51fbb6f4705f3d408d1dada843bc54ff24ad35f18cea61b4b03b3',
     armv7l: 'e89045825ce51fbb6f4705f3d408d1dada843bc54ff24ad35f18cea61b4b03b3',
     x86_64: '3d99c7c90b6ea63856fd9b469cdbdb4c2f00db6a549d7f3973e5efea25b65536',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-gtk3'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "To get started, type 'geany'.".lightblue
    puts
    puts "To completely uninstall, execute the following:".lightblue
    puts "crew remove geany".lightblue
    puts "rm -rf ~/.config/geany".lightblue
    puts
  end
end
