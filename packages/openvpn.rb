require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.6'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/OpenVPN/openvpn/archive/v2.6.6.tar.gz'
  source_sha256 '81415358b89660c9da98d9cf26fd4942fa806fa8f653529fa100a3090c8a3951'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.6_armv7l/openvpn-2.6.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.6_armv7l/openvpn-2.6.6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.6_x86_64/openvpn-2.6.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '19b7b4a5ca495f7d3d690246e0e9898c9b09530cea21bd237c673f8bc45b235f',
     armv7l: '19b7b4a5ca495f7d3d690246e0e9898c9b09530cea21bd237c673f8bc45b235f',
     x86_64: '92e8c9704b3eb58fbb7dedddb5562e8feb6be1c51a28b19841d8ed54b8365aa4'
  })

  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libmbedtls' => :build
  depends_on 'libnl3' # R
  depends_on 'linux_pam' # R
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'mold' => :build
  depends_on 'openssl' # R
  depends_on 'py3_docutils' => :build

  run_tests
end
