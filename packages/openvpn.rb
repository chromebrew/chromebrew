require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.7.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40b53f3efc0fa76468858ebd6c028b2d5da9448b82806310809ac45b031241fe',
     armv7l: '40b53f3efc0fa76468858ebd6c028b2d5da9448b82806310809ac45b031241fe',
     x86_64: '936a43fe1d03e8f3b448f1104da2e4dcc5e75324a9d3701dd83de759576ad111'
  })

  depends_on 'e2fsprogs' => :executable
  depends_on 'glibc' # R
  depends_on 'krb5' => :executable
  depends_on 'libcap_ng' => :executable
  depends_on 'libeconf' # R
  depends_on 'libmbedtls' => :build
  depends_on 'libnl3' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'linux_pam' # R
  depends_on 'lz4' => :executable
  depends_on 'lzo' => :executable
  depends_on 'mold' => :build
  depends_on 'openssl' => :executable
  depends_on 'py3_docutils' => :build

  run_tests
end
