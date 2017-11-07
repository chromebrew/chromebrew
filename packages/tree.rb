require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '1.7.0'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-1.7.0.tgz'
  source_sha256 '6957c20e82561ac4231638996e74f4cfa4e6faabc5a2f511f0b4e3940e8f7b12'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tree-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd02021fe3f0dba5e093b8124eb2fbf06daf207e26ab0f1ebf18c211418465d79',
     armv7l: 'd02021fe3f0dba5e093b8124eb2fbf06daf207e26ab0f1ebf18c211418465d79',
       i686: '81a4cb42cb1be8daf590628fe732903dd3cb048569e26224aebc1b8e2a5433da',
     x86_64: 'b17546851d8bc23cb0d21ec6fd0bf7a73fff74206f9fbb58e088d6ba6df58a4d',
  })

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '25s,=,=$(DESTDIR),' Makefile"
    system "sed -i '27s,=,=$(DESTDIR),' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
