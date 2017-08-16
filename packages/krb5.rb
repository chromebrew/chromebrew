require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.15.1'
  source_url 'http://web.mit.edu/kerberos/dist/krb5/1.15/krb5-1.15.1.tar.gz'
  source_sha256 '437c8831ddd5fde2a993fef425dedb48468109bb3d3261ef838295045a89eb45'

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
