require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.7.0.tar.bz2'
  source_sha256 '36c8f93b6595437c8cfbc9f08618bcb3041cbd303e140a0013f88e4c2977cb54'


  depends_on 'llvm' => ':build'
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
