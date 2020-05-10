require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.4'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.bz2'
  source_sha256 'e4d05911a3165d3b18321cc067fdd2f023f06436e391c6a28dff618a78d2e733'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '85fd777e81a2dd5e3954e82465291c2c889567b7ae8bbb7a3e51b196c8ed35dd',
     armv7l: '85fd777e81a2dd5e3954e82465291c2c889567b7ae8bbb7a3e51b196c8ed35dd',
       i686: '3fa0eb953101a37c924a22fa28699d1cb7e4a85bd79b7c492f087df91e108e42',
     x86_64: '74d475f18422369cea3e5ca5591c55aa2caaac2ad23abaf17e5678daec534cf9',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
