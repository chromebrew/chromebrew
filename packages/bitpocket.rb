require 'package'

class Bitpocket < Package
  description '"DIY Dropbox" or "2-way directory (r)sync with proper deletion"'
  homepage 'https://github.com/ku1ik/bitpocket'
  version '0.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ku1ik/bitpocket.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38c2581f61ebc605a338476207422a8b380e4e45d304278cb77b9c0df89a387f',
     armv7l: '38c2581f61ebc605a338476207422a8b380e4e45d304278cb77b9c0df89a387f',
       i686: '1345089ff0416f3313258b3405a80f9ba34c993bd0c9b6c197c645a1f00182af',
     x86_64: '71be57b2db62c153fcb05071a0e3a71077d376892a81a04f3da1e314c02c765e'
  })

  def self.install
    FileUtils.install 'bin/bitpocket', "#{CREW_DEST_PREFIX}/bin/bitpocket", mode: 0o755
  end
end
