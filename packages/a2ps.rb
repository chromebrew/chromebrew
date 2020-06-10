require 'package'

class A2ps < Package
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'http://www.gnu.org/software/a2ps/'
  version '4.14-1'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/a2ps/a2ps-4.14.tar.gz'
  source_sha256 'f3ae8d3d4564a41b6e2a21f237d2f2b104f48108591e8b83497500182a3ab3a4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6c9c237e5d9e51b8d19fb74522b7a60dabe74c958061a080f1f338b289ba254',
     armv7l: 'c6c9c237e5d9e51b8d19fb74522b7a60dabe74c958061a080f1f338b289ba254',
       i686: '9a877e68120feb3f8ec9c50c36b9d378186fb00bc2883670bdc42089411e4607',
     x86_64: '28b5f46158587be75ff873d64805f480af0a3bbfa2f764abf815117d0b907f48',
  })

  depends_on 'gperf'
  depends_on 'filecmd'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/tmp"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

