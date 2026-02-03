require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c48f29bfbc8171b765feecf0c3a957cc08458178cd3c9523ea351a07ba17045b',
     armv7l: 'c48f29bfbc8171b765feecf0c3a957cc08458178cd3c9523ea351a07ba17045b',
       i686: '829c325641fca7dcbe9430bc7f1ceb556f6d8f947ebef53b55b724f18b6c04e0',
     x86_64: 'e277d0a63ca0e3a1d6f13b8b4969ce00ee7b21f028ca6922cc8e1b37a31cc604'
  })

  depends_on 'glibc' # R
  depends_on 'libnl3'
end
