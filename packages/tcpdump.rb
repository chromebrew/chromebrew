require 'buildsystems/autotools'

class Tcpdump < Autotools
  description 'A powerful command-line packet analyzer.'
  homepage 'https://www.tcpdump.org/'
  version '4.99.7'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.tcpdump.org/release/tcpdump-#{version}.tar.gz"
  source_sha256 '8be364e28d3b745ef1459b385cd2f4bc0e1ebad7a5d2ebdf70071d6c9b5b9a54'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97216170c3fc61536107cd753e52d530d4ca280d953cd81400ac2b52cc336500',
     armv7l: '97216170c3fc61536107cd753e52d530d4ca280d953cd81400ac2b52cc336500',
       i686: 'e1b45f9c9934995f97ddf7cda3b2cab049af7abc0e75e9da78f89764cc5c84dd',
     x86_64: 'fdfd0214024537e3d03176817982b0e616d4c5637e8044360f8d4ff85b868962'
  })

  depends_on 'glibc' => :executable
  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'libcap_ng' => :executable
  depends_on 'libpcap'
  depends_on 'libpcap' => :executable
  depends_on 'openssl'
  depends_on 'openssl' => :executable

  autotools_configure_options "--with-user=#{USER}"
end
