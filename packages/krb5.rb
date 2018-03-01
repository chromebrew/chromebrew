require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.15.1'
  source_url 'http://web.mit.edu/kerberos/dist/krb5/1.15/krb5-1.15.1.tar.gz'
  source_sha256 '437c8831ddd5fde2a993fef425dedb48468109bb3d3261ef838295045a89eb45'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1545c7771436e083222ce47c143fd2567ecb19e93d708b77a62c643a7bcd17b3',
     armv7l: '1545c7771436e083222ce47c143fd2567ecb19e93d708b77a62c643a7bcd17b3',
       i686: '4b6ba2087e93e587536b718a71a8411134ce7623c009babd963a8beaa35ead97',
     x86_64: '67bcd5c0322ff281def4e9ac1417bb47baf612bad89387b738f0dee7ebfebdb2',
  })

  def self.build
    Dir.chdir "src" do
      system "./configure --without-system-verto"
      system "make"
    end
  end

  def self.install
    Dir.chdir "src" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
