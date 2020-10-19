require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2020.1'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2020.1.tar.bz2'
  source_sha256 '54a153f139035a376c075845dd058049177212da94d7a9707cf9468367b699d2'


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
