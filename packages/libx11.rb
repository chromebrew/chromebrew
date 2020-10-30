require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.12-1'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.12.tar.bz2'
  source_sha256 'f108227469419ac04d196df0f3b80ce1f7f65059bb54c0de811f4d8e03fd6ec7'


  depends_on 'llvm' => ':build'
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'
  
  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
