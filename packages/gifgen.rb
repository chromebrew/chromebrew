require 'package'

class Gifgen < Package
  description 'Simple high quality GIF encoding'
  homepage 'https://github.com/lukechilds/gifgen'
  version '1.2.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/lukechilds/gifgen.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2dba49545770001afebe03f781972eab7ae43fcacb5d8b2cf09ec9569ce8a4d',
     armv7l: 'c2dba49545770001afebe03f781972eab7ae43fcacb5d8b2cf09ec9569ce8a4d',
     x86_64: '83e2435246078a0e70b0ab58a6a5d296c02809ab803c30bbd6c2aee2d294756a'
  })

  depends_on 'ffmpeg' => :executable
  depends_on 'help2man' => :build

  def self.install
    system 'help2man -N ./gifgen > gifgen.1'
    FileUtils.install 'gifgen', "#{CREW_DEST_PREFIX}/bin/gifgen", mode: 0o755
    FileUtils.install 'gifgen.1', "#{CREW_DEST_PREFIX}/man/man1/gifgen.1", mode: 0o644
  end
end
