require 'package'

class Apg < Package
  description 'APG (Automated Password Generator) is a toolset for random password generation.'
  homepage 'http://www.adel.nursat.kz/apg/'
  version '2.2.3.dfsg.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/a/apg/apg_2.2.3.dfsg.1.orig.tar.gz'
  source_sha256 'c7e3c556426e2d5d2f599873a71100c5f6d14fa8784e0b1d879916784de801df'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apg/2.2.3.dfsg.1_armv7l/apg-2.2.3.dfsg.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apg/2.2.3.dfsg.1_armv7l/apg-2.2.3.dfsg.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apg/2.2.3.dfsg.1_i686/apg-2.2.3.dfsg.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apg/2.2.3.dfsg.1_x86_64/apg-2.2.3.dfsg.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1e4391fe1edf715853f97bd551f1f9e8a35f562bfd12f3f1838256640e75068f',
     armv7l: '1e4391fe1edf715853f97bd551f1f9e8a35f562bfd12f3f1838256640e75068f',
       i686: '6a299f28d79d33db6a2b1794e7fbfd27cbc48f4c7bb18a683dcf18c019c28628',
     x86_64: '7ddeb08e8633166b18c147a8c85558badad8626a1e97ff6d6383c6056c0199d2'
  })

  def self.patch
    system 'curl -#LO https://httpredir.debian.org/debian/pool/main/a/apg/apg_2.2.3.dfsg.1-5.debian.tar.xz'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('apg_2.2.3.dfsg.1-5.debian.tar.xz')) == '8305fdb424d934f4d217b7910e0b971cff205b28857b9dc9df95e38bd1aaa9a0'
    system 'tar xf apg_2.2.3.dfsg.1-5.debian.tar.xz'
    FileUtils.rm 'debian/patches/series'
    system "sed -i '10,16d' debian/patches/Makefile"
    system "for i in debian/patches/*; do patch -Np1 -i \"\${i}\"; done"
    system "sed -i 's:INSTALL_PREFIX = /usr/local:INSTALL_PREFIX = #{CREW_DEST_PREFIX}:' Makefile"
    system "sed -i 's:FLAGS = -Wall:FLAGS = -Wall -O2 -pipe -flto=auto:' Makefile"
    system "sed -i 's:root:$(whoami):g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
