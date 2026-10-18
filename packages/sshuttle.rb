require 'buildsystems/python'

class Sshuttle < Python
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle'
  version '2.0.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7a0e1bb4ce9d88975838dc6291572efda099710e6649855eeedfdba625c1b69',
     armv7l: 'f7a0e1bb4ce9d88975838dc6291572efda099710e6649855eeedfdba625c1b69',
       i686: 'f818afd3a7daf949a707abff41fecea7a580aea79b97ad7256f14cd0b3165dd3',
     x86_64: '1f88a52b9c1da7cb0dad102c280462976a81a4e42a8d7933c1311235741d2787'
  })

  depends_on 'py3_hatchling'
  depends_on 'py3_psutil'
  depends_on 'python3' => :logical
end
