require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '7.6'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_7_6_P1.tar.gz'
  source_sha256 'b358ed7afa55bfed9ddc618e3c24ca6de5cd9d64b0e347b8262934038ec82a1a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'autoconf' => :build
  depends_on 'compressdoc' => :build

  def self.build
    system "autoconf"
    system "autoheader"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man5"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
