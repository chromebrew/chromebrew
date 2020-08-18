require 'package'
    
class Sxhkd < Package
  description 'Simple X HotKey Daemon'
  homepage "https://github.com/baskerville/sxhkd"
  version '0.6.2'
  compatibility 'all'
  source_url 'https://github.com/baskerville/sxhkd/archive/0.6.2.tar.gz'
  source_sha256 '1edc8b1a8b3631c10ba9cb9df1181830dacbbdf77adb558e31d5dd2029637386'

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
