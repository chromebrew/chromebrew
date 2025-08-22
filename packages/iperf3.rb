require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.19.1'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a0da34022f0e393734ab267995399f505186cafff157a5873475f370fe98316',
     armv7l: '4a0da34022f0e393734ab267995399f505186cafff157a5873475f370fe98316',
     x86_64: 'bea966ad5a7b61eb1650f9ae975cbb45aded37e4a641d12b538d832294223c1f'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
