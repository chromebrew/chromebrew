require 'buildsystems/autotools'

class Tcpdump < Autotools
  description 'A powerful command-line packet analyzer.'
  homepage 'https://www.tcpdump.org/'
  version '4.99.5'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.tcpdump.org/release/tcpdump-#{version}.tar.gz"
  source_sha256 '8c75856e00addeeadf70dad67c9ff3dd368536b2b8563abf6854d7c764cd3adb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2484e27fdb82d48eb6f37e136946363e7262aefdae042946c58402a927e4d4cb',
     armv7l: '2484e27fdb82d48eb6f37e136946363e7262aefdae042946c58402a927e4d4cb',
       i686: 'aa3b1ddc5b898acc583aa9cb80f5c3a1d2a686ced673e370453640fbcbc480b0',
     x86_64: 'cb1c4c36277536dd7d1d1dcfecae680cec10182bee361697b5d018542a025e60'
  })

  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'libpcap'
  depends_on 'openssl'
  depends_on 'glibc' # R

  autotools_configure_options "--with-user=#{USER}"
end
