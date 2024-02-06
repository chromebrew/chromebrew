require 'buildsystems/autotools'

class Arpscan < Autotools
  description 'Arp-scan is an ARP (Address Resolution Protocol) scanning and fingerprinting tool.'
  homepage 'https://github.com/royhills/arp-scan'
  version '1.10.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/royhills/arp-scan.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e41d1d62e226fbecde17b9dfcff48a34073dfa0f5a104880a635b6f069838491',
     armv7l: 'e41d1d62e226fbecde17b9dfcff48a34073dfa0f5a104880a635b6f069838491',
       i686: 'a3f45ce0b3793b9d72f943d7cfea0f89c3b4e5a39c2bb1eb63b91a3204e668d2',
     x86_64: 'ebad569737c9d16d0e3d6b2ca912b2f524303e4b71eb0fc19996e17b974033c5'
  })

  depends_on 'libpcap'
  depends_on 'libnet' => :build
  # Perl dependencies needed for get-oui
  depends_on 'perl_lwp_useragent'
  depends_on 'perl_http_request'
  depends_on 'perl_clone'
  depends_on 'perl_uri'
  depends_on 'perl_http_date'
  depends_on 'perl_try_tiny'
  depends_on 'perl_text_csv'

  run_tests
end
