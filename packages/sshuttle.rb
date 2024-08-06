require 'buildsystems/python'

class Sshuttle < Python
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle'
  version '1.1.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8c81a5d421f5c393ed4d512c8ec40fdbddafc6e203fa21083997b004df81a05',
     armv7l: 'f8c81a5d421f5c393ed4d512c8ec40fdbddafc6e203fa21083997b004df81a05',
       i686: 'ced49c2fd3203e735589e16ab842a9187d4c9b0abdf6d27353d013d5497b7fe9',
     x86_64: '1e168c1546b5c8f10f8e99a7c0dde8edb9b5d79a6a53a398ec5bd3e95705557e'
  })

  depends_on 'py3_psutil'
  depends_on 'python3'
end
