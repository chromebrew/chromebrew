require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.4.57'
  version @_ver
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 'c7ba47e1e6ecb5b436f3d43281df57abeffa99262141aec822628bc220f6b45a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'eafc72703f61b96747a8d37e6fcdac7d5d400832da9f9205936188dda6e57a46',
      armv7l: 'eafc72703f61b96747a8d37e6fcdac7d5d400832da9f9205936188dda6e57a46',
        i686: 'e981259b1c30688d15c3b8ca83ea87fe83bd41f1923322b274df04e6e10611f0',
      x86_64: 'e0ca5de88bd9808f8e30beb0861bec2da9c3686b538f4563603b19fbd50b6278',
  })

  depends_on 'libcyrussasl'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} --disable-slapd"
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
