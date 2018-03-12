require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.16'
  source_url 'http://web.mit.edu/kerberos/dist/krb5/1.16/krb5-1.16.tar.gz'
  source_sha256 'faeb125f83b0fb4cdb2f99f088140631bb47d975982de0956d18c85842969e08'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.build
    Dir.chdir "src" do
      system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
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
