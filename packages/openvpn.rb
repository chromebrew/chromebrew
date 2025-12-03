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
    aarch64: '1d97aaadde2a82b0d7528da9138c47932422554a172bce51c82cb21281d3a953',
     armv7l: '1d97aaadde2a82b0d7528da9138c47932422554a172bce51c82cb21281d3a953',
     x86_64: '0fb418b73729a2a31a29e8ee42ffa88f13d5aa46d788d1b542389cf78cf87bfd'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libmbedtls' => :build
  depends_on 'libnl3' # R
  depends_on 'libtirpc' # R
  depends_on 'linux_pam' # R
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'mold' => :build
  depends_on 'openssl' # R
  depends_on 'py3_docutils' => :build

  run_tests
end
