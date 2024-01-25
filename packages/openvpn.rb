require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.8'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71aacc0355e0449f445a2ac84c16bba406f0f5f71fa59cc74b0acaf8d17286d6',
     armv7l: '71aacc0355e0449f445a2ac84c16bba406f0f5f71fa59cc74b0acaf8d17286d6',
     x86_64: '1a39cb8676cc5dc683e63d3f54ed6ddf05dd2cac44ba8c386a66a6898030b93d'
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
