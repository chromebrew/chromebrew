require 'package'

class Apg < Package
  description 'APG (Automated Password Generator) is a toolset for random password generation.'
  homepage 'http://www.adel.nursat.kz/apg/'
  version '2.3.0b'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/a/apg/apg_2.2.3.dfsg.1.orig.tar.gz'
  source_sha256 'c7e3c556426e2d5d2f599873a71100c5f6d14fa8784e0b1d879916784de801df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89bcf52ad78e2ee3853ef09f738cd3c5b9ba3345741a66ed28d64ef994dcf1c7',
     armv7l: '89bcf52ad78e2ee3853ef09f738cd3c5b9ba3345741a66ed28d64ef994dcf1c7',
       i686: '2607cbceedf2806bc73ec039fe27d9d6551a8b18d844487be4b5116ba3cb1d5e',
     x86_64: 'dd6c364cd1e9a7d7b5ce31be871315dcd2d014809235b916ad6cfc78734699e3'
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
