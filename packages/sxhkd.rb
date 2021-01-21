require 'package'

class Sxhkd < Package
  description 'Simple X HotKey Daemon'
  homepage "https://github.com/baskerville/sxhkd"
  version '0.6.2'
  compatibility 'all'
  source_url 'https://github.com/baskerville/sxhkd/archive/0.6.2.tar.gz'
  source_sha256 '1edc8b1a8b3631c10ba9cb9df1181830dacbbdf77adb558e31d5dd2029637386'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sxhkd-0.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sxhkd-0.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sxhkd-0.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sxhkd-0.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ddc4774617d8238d80e4319771f1a9d6ef76f91337f76fa68aa49c543042bed9',
     armv7l: 'ddc4774617d8238d80e4319771f1a9d6ef76f91337f76fa68aa49c543042bed9',
       i686: '0363cb29cef86ce890375b5b6f471b8f07bab7b4762d230a9e550e7cdb8ab29b',
     x86_64: '8781a6790da9fa13c94e6b751f99fa448a9380d4be599aec7c56bad4a9b7e3b5',
  })

  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util'
  depends_on 'libxcb'

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make install"
  end
end
