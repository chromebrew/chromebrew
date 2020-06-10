require 'package'

class Mtools < Package
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.18'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/mtools/mtools-4.0.18.tar.bz2'
  source_sha256 '59e9cf80885399c4f229e5d87e49c0c2bfeec044e1386d59fcd0b0aead6b2f85'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mtools-4.0.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mtools-4.0.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mtools-4.0.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mtools-4.0.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4131e41594042d4cc3f1ce65fc19674a89df1c64a5da4915f1498d3339a5dc9',
     armv7l: 'f4131e41594042d4cc3f1ce65fc19674a89df1c64a5da4915f1498d3339a5dc9',
       i686: 'bf796d05c23244ef81bcf417a94194d7655c47df0a6dc21ecbf19d74e0476999',
     x86_64: 'e94e6a2b813f8952451093fafe34e7205015486d3532631ba6384e6bd2989693',
  })

  def self.build
    system './configure --without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
