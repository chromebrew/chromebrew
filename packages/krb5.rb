require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.19'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.tar.gz'
  source_sha256 'bc7862dd1342c04e1c17c984a268d50f29c0a658a59a22bd308ffa007d532a2e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.19-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '69f5fdec7c6c2c409b2d328c325954fdc8f8cf21024f84059968f052437c160a',
     armv7l: '69f5fdec7c6c2c409b2d328c325954fdc8f8cf21024f84059968f052437c160a',
       i686: '09f43b2cb5ba53b6699f9db04b7886c4d1a1ffbb6d4510aa3f79b67f77187434',
     x86_64: '1a3963a507e42b7b2d9faa21724c2945d028b6a1f717a4ba0d48dee206698f33'
  })

  def self.build
    Dir.chdir 'src' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
      --without-system-verto"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
