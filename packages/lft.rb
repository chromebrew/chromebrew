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
    aarch64: '223307dae3bb941b29bb727f198c4fd9427896928f2fa210ef91363ef03710f2',
     armv7l: '223307dae3bb941b29bb727f198c4fd9427896928f2fa210ef91363ef03710f2',
       i686: '4e98aa1912a265dc2e4540ea42bcf90cc3ba8ca3a33f61feb6c7f832995afb11',
     x86_64: '9324e0ffc3f47b604f6515bb6c61d3fa625c905f3e0842ef070743c7f8659f6a'
  })

  depends_on 'c_ares' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
end
