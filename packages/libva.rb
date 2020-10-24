require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.9.0'
  compatibility 'all'
  source_url 'https://github.com/intel/libva/releases/download/2.9.0/libva-2.9.0.tar.bz2'
  source_sha256 'e344c1392dde92696c9ffd9cb3c7277d0a3b912236eb4e0fdedf7f375434584b'


  depends_on 'libdrm'
  depends_on 'llvm'  => ':build'

  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
