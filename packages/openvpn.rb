require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.11'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d3d0dbccdadfaf57a27eddd20cdf872c02906e5619c067943aef568bc32cb41',
     armv7l: '1d3d0dbccdadfaf57a27eddd20cdf872c02906e5619c067943aef568bc32cb41',
     x86_64: '445a076d36c354d72c32f3af8318f9e06f750764078e1150793e13c7f2cfe9a6'
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
