require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '3.3.40-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://codeberg.org/smxi/inxi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6324c32faf050c3137af8ca8bdd3abaeaef2a392380439f36a605d967bacb51',
     armv7l: 'e6324c32faf050c3137af8ca8bdd3abaeaef2a392380439f36a605d967bacb51',
       i686: 'd7a8282fdb2b7c3a2a7bc5f28b77d78ed144285e875b2a7271f9969e37637e89',
     x86_64: 'd65adc2109a6fb91331181c28b20ebc06c1b8a8732f4869a855807281b4a7df0'
  })

  depends_on 'gawk'
  depends_on 'perl'

  def self.install
    FileUtils.install 'inxi', "#{CREW_DEST_PREFIX}/bin/inxi", mode: 0o755
    FileUtils.install 'inxi.1', "#{CREW_DEST_MAN_PREFIX}/man1/inxi.1", mode: 0o644
  end
end
