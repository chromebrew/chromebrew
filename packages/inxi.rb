require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '3.3.35-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://codeberg.org/smxi/inxi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '238537279b21affc02dc28973d5af2cb3db3ec4b80327389d276adeaf8bbc8f6',
     armv7l: '238537279b21affc02dc28973d5af2cb3db3ec4b80327389d276adeaf8bbc8f6',
       i686: '99135aa3e34c39e4d3624fbb9e1a36adfda08d53cc76fdd88772a33c27afc71a',
     x86_64: 'dd850645b3f5ba9528257250ae2851b26c964c83b669d40a26352407f0d5c619'
  })

  depends_on 'gawk'
  depends_on 'perl'

  def self.install
    FileUtils.install 'inxi', "#{CREW_DEST_PREFIX}/bin/inxi", mode: 0o755
    FileUtils.install 'inxi.1', "#{CREW_DEST_MAN_PREFIX}/man1/inxi.1", mode: 0o644
  end
end
