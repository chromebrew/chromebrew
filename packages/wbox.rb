require 'package'

class Wbox < Package
  description 'Wbox aims to help you having fun while testing HTTP related stuff.'
  homepage 'http://www.hping.org/wbox/'
  version '5'
  source_url 'http://www.hping.org/wbox/wbox-5.tar.gz'
  source_sha256 '1589d85e83c8ee78383a491d89e768ab9aab9f433c5f5e035cfb5eed17efaa19'

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_DIR}/usr/local/bin"
    FileUtils.cp "wbox", "#{CREW_DEST_DIR}/usr/local/bin/"
  end
end
