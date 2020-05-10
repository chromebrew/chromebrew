require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '1.8.0'
  compatibility 'all'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-1.8.0.tgz'
  source_sha256 '715d5d4b434321ce74706d0dd067505bb60c5ea83b5f0b3655dae40aa6f9b7c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a7505aeb61a91e3735cd89e139632af5229a41d693e7b088fcdd6b5db630504a',
     armv7l: 'a7505aeb61a91e3735cd89e139632af5229a41d693e7b088fcdd6b5db630504a',
       i686: '648c1628521180d65f0ccdd12a9e1a90c3571988dc9debda621878dd06d9eef6',
     x86_64: '32d029842308d0d237c09109248bb9244a6a2cac38eba679674b7b26555f11a2',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '25s,=,=$(DESTDIR),' Makefile"
    system "sed -i '27s,=,=$(DESTDIR),' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
