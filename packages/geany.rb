require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '1.37'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://download.geany.org/geany-1.37.tar.bz2'
    source_sha256 'dde52584823b769c56704c27dbedddb7a6bbaf4eacb9587d10bbc387816e3d51'
    depends_on 'gtk3'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.37-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geany-1.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbdb1255d7ce63c4261ebfd53bae0639f898e71adaba836783c429ea962e071b',
     armv7l: 'bbdb1255d7ce63c4261ebfd53bae0639f898e71adaba836783c429ea962e071b',
     x86_64: 'eb7e491ae1c62a634ce3a28f3ecf55dacce765ed2140098d1236799f15383380',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-api-docs=no --enable-html-docs=no --enable-pdf-docs=no"
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
