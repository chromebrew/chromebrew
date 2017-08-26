require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'http://scons.org/'
  version '2.5.1'
  source_url 'http://prdownloads.sourceforge.net/scons/scons-2.5.1.tar.gz'
  source_sha256 '0b25218ae7b46a967db42f2a53721645b3d42874a65f9552ad16ce26d30f51f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scons-2.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scons-2.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scons-2.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scons-2.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e48938c7135fdd9ed84b5d13cf4d065fec22bcadbad774adacff9587ec1827d9',
     armv7l: 'e48938c7135fdd9ed84b5d13cf4d065fec22bcadbad774adacff9587ec1827d9',
       i686: '2e32fe117949c68ee183c63aeaf8710c9a541674b9528ce123836937488f589f',
     x86_64: '5b9b42032a1baa5fc87de3ffae70f1ada846eb99ecd72319a7e49dbaba02e5cd',
  })

  depends_on 'python27'

  def self.build
    nil
  end

  def self.install
    system "python2.7 setup.py install --prefix=/usr/local --root=#{CREW_DEST_DIR}"
  end
end
