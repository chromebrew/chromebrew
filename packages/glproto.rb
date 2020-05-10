require 'package'

class Glproto < Package
  description 'This extension defines a protocol for the client to send 3D rendering commands to the X server.'
  homepage 'https://github.com/freedesktop/glproto'
  version '1.4.17'
  compatibility 'all'
  source_url 'https://github.com/freedesktop/glproto/archive/glproto-1.4.17.tar.gz'
  source_sha256 'b419c969412ad5c02dd53a0169041766c151ef599bf58b8dad70686fa1001c58'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a5b1a0f75c5196a5abba05c02f4bd89ca04436ea4af8570f4e1466c2f9979a74',
     armv7l: 'a5b1a0f75c5196a5abba05c02f4bd89ca04436ea4af8570f4e1466c2f9979a74',
       i686: '0571a3d7e5a2e8c1816da6ca42660fa196d716f312d75e7b9d9d2649ae1b2006',
     x86_64: '8a473bec54cbe19e192fb65297f11b22c200b662351032f163ef1f34c7c73f8d',
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
