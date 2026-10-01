require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.22'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dc61707624d78de67efddb7f0cbbb4a3189dc3ffbdc43b532c100ecee5b6366',
     armv7l: '5dc61707624d78de67efddb7f0cbbb4a3189dc3ffbdc43b532c100ecee5b6366',
     x86_64: '524da608f9fe7c457dea7b583f4e70b9d9bc7e31af76f1f37d9eeb4927d50a6c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
