require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '3.3.41-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://codeberg.org/smxi/inxi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0eaa099a94004a81903fdbe3e533d6318ed7714ad2d179edd46b6794775ad31',
     armv7l: 'd0eaa099a94004a81903fdbe3e533d6318ed7714ad2d179edd46b6794775ad31',
       i686: 'aa1f8aaa4db38e51375b867fc9e51bf639b67d1988af724476d8a19376496a9f',
     x86_64: '94e53a99d1d7e0b5c2b4a82bdf7176ee38fc2712317c44f1829ac37c7b853fe0'
  })

  depends_on 'gawk'
  depends_on 'perl'

  def self.install
    FileUtils.install 'inxi', "#{CREW_DEST_PREFIX}/bin/inxi", mode: 0o755
    FileUtils.install 'inxi.1', "#{CREW_DEST_MAN_PREFIX}/man1/inxi.1", mode: 0o644
  end
end
