require 'package'

class Mtr < Package
  description "mtr combines the functionality of the 'traceroute' and 'ping' programs in a single network diagnostic tool."
  homepage 'https://www.bitwizard.nl/mtr/'
  version '0.93'
  source_url 'ftp://ftp.bitwizard.nl/mtr/mtr-0.93.tar.gz'
  source_sha256 '229c673d637bd7dbb96471623785a47e85da0b1944978200c949994c1e6af10d'

  binary_url ({
    aarch64: '',
     armv7l: '',
     x86_64: '',
       i686: ''
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
     x86_64: '',
       i686: '',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}", "--without-gtk",
        "LDFLAGS=-Wl,-rpath,#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "sudo", "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
