require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'https://ftpmirror.gnu.org/aspell/dict/0index.html'
  version '2018.04.16-0'
  source_url 'https://ftpmirror.gnu.org/aspell/dict/en/aspell6-en-2018.04.16-0.tar.bz2'
  source_sha256 'f11071e74b0c0753f4afabf024941a5c3a96bafe3879211ebd47bc34e76fbd2f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2018.04.16-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2018.04.16-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2018.04.16-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2018.04.16-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '71c28fd24310c67fc198a2138a449b45320540c06596ba3f2a69effdf9a724de',
     armv7l: '71c28fd24310c67fc198a2138a449b45320540c06596ba3f2a69effdf9a724de',
       i686: 'b3141934cab8704c20785f1b1d3a636338da6308634447ba1c40cdf55ca48d23',
     x86_64: 'a2df41132ccc0ee75025d43096a35e4bc182c701b074f6e87b1b3d45b55c5cf7',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
