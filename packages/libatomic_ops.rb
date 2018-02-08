require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.2'
  source_url 'https://github.com/ivmai/libatomic_ops/archive/v7.6.2.tar.gz'
  source_sha256 'f0290ebe34bc8f62d153aab4b644e4365b82a63820f1ff861282d460e44f10f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6132785a1a7dae190ff7fe4ae1bc9a24b2b980bb5d400ef18bc9e73edb75b589',
     armv7l: '6132785a1a7dae190ff7fe4ae1bc9a24b2b980bb5d400ef18bc9e73edb75b589',
       i686: 'c6328e905ba99480c4402914f91c969c5b6e5395f4ca314b62f52c14e3b7c7ce',
     x86_64: '782b4abc8cffcb8bd8d4f0b23856bc0d2b2603eab29bbbfab9732050840f2ad6',
  })

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkgconfig' => :build

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
