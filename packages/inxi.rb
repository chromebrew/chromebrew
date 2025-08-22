require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '3.3.38-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://codeberg.org/smxi/inxi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e47233793b8d383936d5ce2942dbf3cb99478287072225676eb692bfa5dee001',
     armv7l: 'e47233793b8d383936d5ce2942dbf3cb99478287072225676eb692bfa5dee001',
       i686: 'bb1d27dc24b4d18f6d4777ad6b4b4bcef0355a800c4fe866186e1574578956fc',
     x86_64: '89215fd36872af7e77459469d9f38c80f2c0e0eaed4133d245c1f1e91175df8f'
  })

  depends_on 'gawk'
  depends_on 'perl'

  def self.install
    FileUtils.install 'inxi', "#{CREW_DEST_PREFIX}/bin/inxi", mode: 0o755
    FileUtils.install 'inxi.1', "#{CREW_DEST_MAN_PREFIX}/man1/inxi.1", mode: 0o644
  end
end
