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
