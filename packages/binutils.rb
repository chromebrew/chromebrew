require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.30-0'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.30.tar.xz'
  source_sha256 '6e46b8aeae2f727a36f0bd9505e405768a72218f1796f0d09757d45209871ae6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4cc7528d1c7f6d5cf6e0cd713a14318272ca1354da9f400571b16a96a889a0eb',
     armv7l: '4cc7528d1c7f6d5cf6e0cd713a14318272ca1354da9f400571b16a96a889a0eb',
       i686: 'cdd19802623b3184f53604813fbf207ca3f758b354cc26378412a9e452c133a2',
     x86_64: 'c36989b8e1c84ff546bbb6d24d8022438e1f5ed17ea1dbe2a65d90ec1356c260',
  })

  def self.build
    system "mkdir -vp build"
    Dir.chdir("build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--enable-shared",
             "--disable-maintainer-mode",
             "--enable-gold",
             "--enable-ld=default",
             "--enable-plugins",
             "--disable-bootstrap",
             "--enable-64-bit-bfd",
             "--disable-werror"
      system 'make'
    end
  end

  def self.install
    Dir.chdir("build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
