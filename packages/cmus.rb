require 'package'

class Cmus < Package
  description 'cmus is a small, fast and powerful console music player for Unix-like operating systems.'
  homepage 'https://cmus.github.io/'
  version '2.7.1'
  source_url 'https://github.com/cmus/cmus/archive/v2.7.1.tar.gz'
  source_sha256 '8179a7a843d257ddb585f4c65599844bc0e516fe85e97f6f87a7ceade4eb5165'

  depends_on 'ffmpeg'

  def self.build
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
    system "./configure prefix=#{CREW_PREFIX} libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
