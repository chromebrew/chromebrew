require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'http://www.x.org'
  version '1.5.2-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXrandr-1.5.2.tar.gz'
  source_sha256 '3f10813ab355e7a09f17e147d61b0ce090d898a5ea5b5519acd0ef68675dcf8e'


  depends_on 'libxrender'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'llvm' => ':build'

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
