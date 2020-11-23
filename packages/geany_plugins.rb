require 'package'

class Geany_plugins < Package
  description 'Geany plugins.'
  homepage 'https://www.geany.org/'
  version '1.37'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://download.geany.org/geany-plugins/geany-plugins-1.37.tar.bz2'
    source_sha256 'c98f9b1303f4ab9bed7587e749cd0b5594d9136a1bf8ba110900d46a17fa9cd8'
    depends_on 'geany'
  end



  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
