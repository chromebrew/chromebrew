require 'package'

class Haveged < Package
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.14'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged/archive/v1.9.14.tar.gz'
  source_sha256 '938cb494bcad7e4f24e61eb50fab4aa0acbc3240c80f3ad5c6cf7e6e922618c3'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --disable-daemon \
            --enable-nistest \
            --enable-enttest \
            --enable-olt \
            --enable-threads"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
