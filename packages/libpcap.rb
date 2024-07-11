require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aea00d0732f23ac5927668c9348c17d99fc065647a8eb1febbb9f72b7e5bb5d8',
     armv7l: 'aea00d0732f23ac5927668c9348c17d99fc065647a8eb1febbb9f72b7e5bb5d8',
       i686: '2c1df45643e3609a583eb7ce95e0d670c742486525e3420e216bbf461c79b395',
     x86_64: '404e78f6713ad6f6e0d2fa665a80a689c165ac59248e19c5fe5638ddc5bac943'
  })

  depends_on 'libnl3'
end
