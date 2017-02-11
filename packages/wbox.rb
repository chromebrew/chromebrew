require 'package'

class Wbox < Package
  version '5'
  source_url 'http://www.hping.org/wbox/wbox-5.tar.gz'
  source_sha1 '5f20fca378c8abf53bb6a9069ecdebeb40a74147'

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_DIR}/usr/local/bin"
    FileUtils.cp "wbox", "#{CREW_DEST_DIR}/usr/local/bin/"
  end
end
