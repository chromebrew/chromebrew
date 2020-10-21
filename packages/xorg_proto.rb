require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2020.1'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2020.1.tar.bz2'
  source_sha256 '54a153f139035a376c075845dd058049177212da94d7a9707cf9468367b699d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08d973f150fb2c4b421f50d2f9e960be4f23b8a096437a2e6b6c88ad15ea6138',
     armv7l: '08d973f150fb2c4b421f50d2f9e960be4f23b8a096437a2e6b6c88ad15ea6138',
       i686: '6c3b8c73f47cde6f77eaaec3bd25c5b9d9fdceb6c8a0e117ef35a32c3e7bc973',
     x86_64: '57daeddeec66badd0a0090624cbd86ac16c6599a5cbeb2977546881ae45a0edb',
  })


  depends_on 'meson' => ':build'
  depends_on 'llvm' => ':build'
  
  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "meson",
	    "-Dprefix=#{CREW_PREFIX}",
	    "-Dlibdir=#{CREW_LIB_PREFIX}",
	    "-Ddatadir=#{CREW_LIB_PREFIX}",
	    '-Dbuildtype=release',
	    "build"
    system "meson configure build"
    system "ninja -C build"
  end
  
  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
