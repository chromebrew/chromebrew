require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.12'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb5caf7c68a195699cb890e7918bb79f10e0e3003960a3cdf2351e6b8ae6b52d',
     armv7l: 'cb5caf7c68a195699cb890e7918bb79f10e0e3003960a3cdf2351e6b8ae6b52d',
     x86_64: '82b50c69a2a2cf439e52be724fe7eb95bfcfa75ed6e77046ab32dbbbd4daeb44'
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
