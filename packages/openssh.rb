require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '7.5'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_7_5_P1.tar.gz'
  source_sha256 '00bfc71a4b8f58554892bae561ea0d7f4a462c6940c16c6c943822baa6ba4f84'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/openssh-7.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/openssh-7.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/openssh-7.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/openssh-7.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fc206e449e3c9de64332664e2fa03d326272c0d1cc62476fa9cd244a4c1a3f36',
     armv7l: 'fc206e449e3c9de64332664e2fa03d326272c0d1cc62476fa9cd244a4c1a3f36',
       i686: 'fcc9fc50e8f830245241412bd2ef1eb45e72618912e157fa6ce21e6134a23cc2',
     x86_64: '5f1043b299a3febeca0090010e2d6d49c2bc3785d19f88a86be17f2783217e9c',
  })

  depends_on 'buildessential'
  depends_on 'autoconf'

  def self.build
    system "autoconf"
    system "autoheader"
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
