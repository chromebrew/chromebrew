require 'package'

class Ed < Package
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.14.2-1'
  source_url 'http://ftpmirror.gnu.org/ed/ed-1.14.2.tar.lz'
  source_sha256 'f57962ba930d70d02fc71d6be5c5f2346b16992a455ab9c43be7061dec9810db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.14.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.14.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.14.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.14.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37fd6bd94df54bb20826ef58131893506bed51b2307fed0924481e53697b093c',
     armv7l: '37fd6bd94df54bb20826ef58131893506bed51b2307fed0924481e53697b093c',
       i686: 'f26afff59244acacd5ee74ff8b194350053c68b4c314142b43a0f664303bd474',
     x86_64: '3f50a5390f50083ab4e3619792b65892637efe1675e8b65effe09404343d347a',
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build

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
