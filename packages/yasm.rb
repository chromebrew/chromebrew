require 'package'

class Yasm < Package
  description 'Yasm is a complete rewrite of the NASM assembler under the new BSD License.'
  homepage 'http://yasm.tortall.net/'
  version '1.3.0-1'
  compatibility 'all'
  source_url 'http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz'
  source_sha256 '3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '09315c4ce83e227350b3f515217a3b77285b42606a7414c80951eb2134937d77',
     armv7l: '09315c4ce83e227350b3f515217a3b77285b42606a7414c80951eb2134937d77',
       i686: '34ba6340b711261bbd5a3b0332fc858418b9eee0344ee12d1e235c049068291a',
     x86_64: '8ec504db1d9c91adb6680f17e328daf6114758cbf2106fc4eb2e8028834b3737'
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CPPFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
