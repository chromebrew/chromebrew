require 'buildsystems/autotools'

class Lft < Autotools
  description "LFT, short for Layer Four Traceroute, is a sort of 'traceroute' that often works much faster (than the commonly-used Van Jacobson method) and goes through many configurations of packet-filters (firewalls)."
  homepage 'https://pwhois.org/lft/'
  version '4.03'
  license 'VOSTROM'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/l/lft/lft_#{version}.orig.tar.gz"
  source_sha256 'd84aff0c2baf57a5c5b21fb3b228eed0ac0e12e5a676b3b3be13e34770b91d17'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '829ab4136846c6f2a4d32bd4b9354af93a4530e41d6d71c2e8d1af722f017d54',
     armv7l: '829ab4136846c6f2a4d32bd4b9354af93a4530e41d6d71c2e8d1af722f017d54',
       i686: 'bf6f37568a230ea794b92a7abd670ff88621b4168e1ed8ceadb0b8aa28b469c8',
     x86_64: '39df7b2ae6c583a80bfbcb7a4e56cb1f5a1de301652f56f0dbe1f818f1d409d3'
  })

  depends_on 'c_ares' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
end
