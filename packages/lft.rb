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
    aarch64: '5aab15d9253b4f9a441347357b8c365f213b539f88aa828f1d88b1d48fad171c',
     armv7l: '5aab15d9253b4f9a441347357b8c365f213b539f88aa828f1d88b1d48fad171c',
       i686: 'dd77a57dccf6a547447107665435abd850ca3dacfa157461e9f10d269dbc8779',
     x86_64: '89b5bdb4e820809fe51cb5003ba033b84f075170afdbb747ac9d4e37330381a4'
  })

  depends_on 'c_ares' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
end
