require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '7.6'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_7_6_P1.tar.gz'
  source_sha256 'b358ed7afa55bfed9ddc618e3c24ca6de5cd9d64b0e347b8262934038ec82a1a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-7.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-7.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-7.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-7.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '929ce84481704dcb7ffc18d7b86b955753adc5ec8b6d3b73142d68fceb972aad',
     armv7l: '929ce84481704dcb7ffc18d7b86b955753adc5ec8b6d3b73142d68fceb972aad',
       i686: '752f4c864ffb5fbacd158d8f0c6fc32f457027434522efa4bdc2beaa37888e87',
     x86_64: '22e4e13c61d74f4b49737031644ce1d5e22a131c5f3c9e32e4b769e27092d188',
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
