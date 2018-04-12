require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.19.2'
  source_url 'https://dist.libuv.org/dist/v1.19.2/libuv-v1.19.2.tar.gz'
  source_sha256 '7cbcf2017e7116cf9da8ec1c6a146d578536b1e479458438873c991f984a53d7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.19.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.19.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.19.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.19.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5bfbdbf3ff78d210edc9517bfeacc021fdc53e916e7f34290cda08098e4ee12c',
     armv7l: '5bfbdbf3ff78d210edc9517bfeacc021fdc53e916e7f34290cda08098e4ee12c',
       i686: '5a8d532be1c828835f7237dd20e722eda12c0717a4f01847f1cad374fc3781cb',
     x86_64: 'ac00cf539fcdf67bb88ff6994d41672578e9e4dd93a26e0b11bd7ffb850ccd37',
  })

  depends_on 'automake'
  depends_on 'glibc'
  depends_on 'libtool'

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
