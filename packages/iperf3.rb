require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.20'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc306c0d841d3a1da00954f36e5ac87a1cc7a13d7c0cc17399ffecdffacdbddd',
     armv7l: 'fc306c0d841d3a1da00954f36e5ac87a1cc7a13d7c0cc17399ffecdffacdbddd',
     x86_64: '0773a7433305562a186cdb1de478bfc34cf99e31addc8b63b7fb231c9b94b701'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
