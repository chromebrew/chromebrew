require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.17'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f73c038224c3e1798c2418e438e0604719aebce8d28a4e87777f84ffac7ca448',
     armv7l: 'f73c038224c3e1798c2418e438e0604719aebce8d28a4e87777f84ffac7ca448',
     x86_64: '5d83fab39584fdb277040c612670fbd5d7e0f4b1e1f14524cf483d16d84ae904'
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
