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

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geany_plugins-1.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geany_plugins-1.37-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geany_plugins-1.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08e0bf95bf7dbf8accb343c29f574513fbcd27259ec967fc4254fe9a8ec2c726',
     armv7l: '08e0bf95bf7dbf8accb343c29f574513fbcd27259ec967fc4254fe9a8ec2c726',
     x86_64: 'b18fe4b41730a581e3c3611887d64e44f0514af7e79070a3b3256c7933e05167',
  })

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
