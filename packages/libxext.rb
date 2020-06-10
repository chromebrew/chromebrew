require 'package'

class Libxext < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.3-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXext-1.3.3.tar.gz'
  source_sha256 'eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7e276a0c202ae655a653605ca15f148c971ae2ea7e4ea2fd19e8f1c339c461ea',
     armv7l: '7e276a0c202ae655a653605ca15f148c971ae2ea7e4ea2fd19e8f1c339c461ea',
       i686: 'a0f5035d88e608f25e2f1acd004cb17131bee04ad60c262272325adcdd519fcf',
     x86_64: '2a8953550c8280583385f48d00a044545d01c5e5f994e5ce2171c1d39256a346',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
