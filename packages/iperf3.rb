require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.21'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/esnet/iperf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23824568517140156bd0419d1ad2862ae2c99e19d966233b2021ed464efbf5eb',
     armv7l: '23824568517140156bd0419d1ad2862ae2c99e19d966233b2021ed464efbf5eb',
     x86_64: '22734a0ea0f4a546faab38a1f05de4ff549c9216113616b0d80ad4315c2d36f3'
  })

  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
end
