require 'package'

class Sluice < Package
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'http://kernel.ubuntu.com/~cking/sluice/'
  version '0.02.06'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/sluice/sluice-0.02.06.tar.gz'
  source_sha256 'a1f06c2e7077e28fedb2b4f82066f6e6396bbd2fb4e8f22ef219ff573cdbe163'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.06-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.06-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.06-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sluice-0.02.06-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b081ce6dc65ec1ef759b69bcba07621f6bb2f9db9259f070a17a1c996bef83d0',
     armv7l: 'b081ce6dc65ec1ef759b69bcba07621f6bb2f9db9259f070a17a1c996bef83d0',
       i686: 'b356314b9fa4ad7554aafac03d11e19adbd970bc1632a45fab964041a4078e8f',
     x86_64: 'eb90754ce6faf50a82258306a94d61f6f092e5898bd0389bdbeb4c3b694eaec0',
  })

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
