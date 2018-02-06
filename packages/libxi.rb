require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org'
  version '1.7.9'
  source_url 'https://github.com/mirror/libXi/archive/libXi-1.7.9.tar.gz'
  source_sha256 'e3bc48654d4c21ac37592e8b41c87a5de73872a243e7b0fb39ebd565be5b943d'

  depends_on 'automake' => :build
  depends_on 'libx11'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
