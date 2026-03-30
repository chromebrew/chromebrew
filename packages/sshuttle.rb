require 'buildsystems/python'

class Sshuttle < Python
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle'
  version '1.3.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98ecc43993defa281c35d189eb108cce6328b44d6966069f8cd7f8648e6dd661',
     armv7l: '98ecc43993defa281c35d189eb108cce6328b44d6966069f8cd7f8648e6dd661',
       i686: 'e8983d74be781d5e263d580ce0323189de24d0a278307e46697bafae375dd0f0',
     x86_64: '31e234e6495766609566f2c9bb4c1238e03a9d5196c7f636496007b65324b75e'
  })

  depends_on 'py3_hatchling'
  depends_on 'py3_psutil'
  depends_on 'python3' => :logical
end
