require 'buildsystems/autotools'

class Lft < Autotools
  description "LFT, short for Layer Four Traceroute, is a sort of 'traceroute' that often works much faster (than the commonly-used Van Jacobson method) and goes through many configurations of packet-filters (firewalls)."
  homepage 'https://pwhois.org/lft/'
  version '3.99'
  license 'VOSTROM'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/l/lft/lft_#{version}.orig.tar.gz"
  source_sha256 'f34707b543391eb887ba8479f7d2c2670bfefc3afb244dc5d34a2a41d7b317eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a90e2877ce481fd076ed3ac7965b509ac750bc1fefb551a3c310339a4852ae0',
     armv7l: '5a90e2877ce481fd076ed3ac7965b509ac750bc1fefb551a3c310339a4852ae0',
       i686: 'ba7a2174a735d0ecd0872111e663f42049ce264c0611beaca7107389fa80f060',
     x86_64: 'c9af65457c2d49d03fe78d14a6acdfe8657979707a4c076a068e86a7124b23a3'
  })

  depends_on 'c_ares' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
end
