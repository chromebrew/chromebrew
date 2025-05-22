require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.19'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d1f11be725fd53e241727abe0759d70edee0b1981b7d11139a4d844c3ef479e',
     armv7l: '6d1f11be725fd53e241727abe0759d70edee0b1981b7d11139a4d844c3ef479e',
     x86_64: '83ffd6ce9d37f74638673bd9fca78206aae34e338cff9eff855c688e6fb157e6'
  })

  depends_on 'openssl' # R
end
