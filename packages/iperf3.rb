require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.22.1'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eff9bfdb30930ddadd5d575fe2ebbcc085f6df91e68ad4c2660e7f550db826a2',
     armv7l: 'eff9bfdb30930ddadd5d575fe2ebbcc085f6df91e68ad4c2660e7f550db826a2',
     x86_64: 'b9ed63641fd34a025a2e5c1c15a72951e047e7a8651ea9993547d1652331e088'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
