require 'package'

class Gifgen < Package
  description 'Simple high quality GIF encoding'
  homepage 'https://github.com/lukechilds/gifgen'
  version '1.1.2'
  source_url 'https://github.com/lukechilds/gifgen/archive/1.1.2.tar.gz'
  source_sha256 '95f69c63158315ad869ff36611026cce1a7d03f8c84716b1c21a44e71e8d6aee'

  depends_on 'ffmpeg'
  depends_on 'help2man'

  def self.install
    system "help2man -N ./gifgen > gifgen.1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp gifgen #{CREW_DEST_DIR}/usr/local/bin"
    system "cp gifgen.1 #{CREW_DEST_DIR}/usr/local/man/man1"
  end
end
