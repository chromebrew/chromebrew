require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '487'
  source_url 'http://www.greenwoodsoftware.com/less/less-487.tar.gz'
  source_sha256 'f3dc8455cb0b2b66e0c6b816c00197a71bf6d1787078adeee0bcf2aea4b12706'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/less-487-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/less-487-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/less-487-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/less-487-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24f7449e9805cc789f5c28b952c0df4e80cc626c5b21e220aeb83850525e910c',
     armv7l: '24f7449e9805cc789f5c28b952c0df4e80cc626c5b21e220aeb83850525e910c',
       i686: '8862293e6c2c07eeffcd0eef489567fa9ceae40754d79d7396d0735631cc65ee',
     x86_64: '4760372abc3b0c68d5f6cb0ec625323cd9496316544badbc8201287763844d61',
  })

  depends_on 'buildessential' => :build
  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
