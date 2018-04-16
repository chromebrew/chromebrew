require 'package'

class Gc < Package
  description 'A garbage collector for C and C++.'
  homepage 'http://www.hboehm.info/gc/'
  version '7.6.4'
  source_url 'http://www.hboehm.info/gc/gc_source/gc-7.6.4.tar.gz'
  source_sha256 'b94c1f2535f98354811ee644dccab6e84a0cf73e477ca03fb5a3758fb1fecd1c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gc-7.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gc-7.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gc-7.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gc-7.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7bccf42832063675f479ab454166774462a256beb33ef4afd305a8d8187f4247',
     armv7l: '7bccf42832063675f479ab454166774462a256beb33ef4afd305a8d8187f4247',
       i686: '4c10f74d94175734e88e97397d73651c2e65e097b340c019e30808b09e0415b7',
     x86_64: '92e09087a398ea9f03af37b8f1d9cf1d49b11573ed19e623bb8605636c94c81d',
  })

  depends_on 'libatomic_ops'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-cplusplus'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
