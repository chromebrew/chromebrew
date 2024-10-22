require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42ec7920be11b75d37215deb924c5737b672f3b886f1552206c51c57097db5d7',
     armv7l: '42ec7920be11b75d37215deb924c5737b672f3b886f1552206c51c57097db5d7',
       i686: 'f95c8c709e8fef174eb131afca6a32be15761e9da964bd394125a8f085be06f2',
     x86_64: '845a155ae4b1ab2f20268f85731b13253c5575270068d5010f2b857f27104b29'
  })

  depends_on 'libnl3'
end
