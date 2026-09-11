require 'buildsystems/autotools'

class Lft < Autotools
  description "LFT, short for Layer Four Traceroute, is a sort of 'traceroute' that often works much faster (than the commonly-used Van Jacobson method) and goes through many configurations of packet-filters (firewalls)."
  homepage 'https://pwhois.org/lft/'
  version '4.01'
  license 'VOSTROM'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/l/lft/lft_#{version}.orig.tar.gz"
  source_sha256 '77a2923dbd10b1e3d2b55d8f3c4144795a80f73772d4f41f5e27751d1f3f0c62'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5043cf6a249f5fa15e7ab825c020bf32fcc4838bcce998a01f21876a9a19537a',
     armv7l: '5043cf6a249f5fa15e7ab825c020bf32fcc4838bcce998a01f21876a9a19537a',
       i686: '07465dcb5c2337ba1f348d7d64e4912205d5766f7e3ff50288bf79c95d276215',
     x86_64: '8e1c192e75910513a76eadb988e29fb91699b42bf0534cbbc574c6d7258dc8a9'
  })

  depends_on 'c_ares' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
end
