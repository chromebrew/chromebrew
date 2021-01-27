require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.18.3'
  compatibility 'all'
  source_url 'http://web.mit.edu/kerberos/dist/krb5/1.18/krb5-1.18.3.tar.gz'
  source_sha256 'e61783c292b5efd9afb45c555a80dd267ac67eebabca42185362bee6c4fbd719'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.18.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.18.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.18.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.18.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3e67fe4422bf86829978f6a1b3ceb2dc62975d1a7eb9a3c6158f6f6deb09cbf1',
      armv7l: '3e67fe4422bf86829978f6a1b3ceb2dc62975d1a7eb9a3c6158f6f6deb09cbf1',
        i686: '60cb4f6e17bac1ce4b92c2c4c5e010101e6855db6b5cb8f5da7368cf793b12fe',
      x86_64: 'f1d105384743a241f172c4d267a35e1ffb49159f4bc76c3ca5e5dbc27f69cc28',
  })

  depends_on 'gawk'

  def self.build
    Dir.chdir "src" do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --without-system-verto"
      system "make"
    end
  end

  def self.install
    Dir.chdir "src" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
