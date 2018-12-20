require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.2.3'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.2.3.tar.xz'
  source_sha256 '3cb07a84ff698b205ea244e36eccb4979dd4e10f2120ebbf58c5f1f700023f29'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4cdc57fdbba01e5b1854c9c2ca84b616835575b5c73232528688b414162a333a',
     armv7l: '4cdc57fdbba01e5b1854c9c2ca84b616835575b5c73232528688b414162a333a',
       i686: '120e83f2906a36d6ce31c4b8ecb1ef7bab63d987b3392a5613b49bc655420178',
     x86_64: '141fd756fb765dda1d110033360be9b4e582ed002d3f6bf895f8df9e5890d43b',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
