require 'package'

class Libxext < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXext-1.3.4.tar.gz'
  source_sha256 '8ef0789f282826661ff40a8eef22430378516ac580167da35cc948be9041aac1'

  depends_on 'llvm' => ':build'
  
  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
