require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.19'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.tar.gz'
  source_sha256 'bc7862dd1342c04e1c17c984a268d50f29c0a658a59a22bd308ffa007d532a2e'

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
