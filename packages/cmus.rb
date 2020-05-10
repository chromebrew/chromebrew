require 'package'

class Cmus < Package
  description 'cmus is a small, fast and powerful console music player for Unix-like operating systems.'
  homepage 'https://cmus.github.io/'
  version '2.7.1'
  compatibility 'all'
  source_url 'https://github.com/cmus/cmus/archive/v2.7.1.tar.gz'
  source_sha256 '8179a7a843d257ddb585f4c65599844bc0e516fe85e97f6f87a7ceade4eb5165'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmus-2.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmus-2.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmus-2.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmus-2.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cdcb470fc90f145b393b899d805f19a73f3be145814ec4221f500cdadb161c47',
     armv7l: 'cdcb470fc90f145b393b899d805f19a73f3be145814ec4221f500cdadb161c47',
       i686: '4d62383f3f933f64eb4f44e54547c3382adf42de43469b1254f7737e07349693',
     x86_64: '9b8b1300a07659371e3178472e0766edf7597a3e76fe9afd468a93a6268763a1',
  })

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
