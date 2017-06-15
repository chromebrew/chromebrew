require "package"

class Mywanip < Package
  description 'Script to grab your WAN IP address using various means.'
  homepage 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88'
  version 'ab4094'
  source_url 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88/archive/b583835e8b2cb7edefc7ccbb911cb8eaf172d341.zip'
  source_sha1 '1c26e5ed07283dbecb5a7cbaae0d9e408bedff89'

  def self.install
    system "chmod +x mywanip"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp mywanip #{CREW_DEST_DIR}/usr/local/bin"
  end
end

