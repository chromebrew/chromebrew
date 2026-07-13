require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.7.5'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3b7dbcf6ecb3383ae44c328becb6564ded51a871d3f1c0414a5e116773c5890',
     armv7l: 'd3b7dbcf6ecb3383ae44c328becb6564ded51a871d3f1c0414a5e116773c5890',
     x86_64: '926d29b2ac56eccc0b00e44d846912b45d310bb6712170635e9c3031c6ae60d7'
  })

  depends_on 'e2fsprogs' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'krb5' => :executable
  depends_on 'libcap_ng' => :executable
  depends_on 'libeconf' # R
  depends_on 'libmbedtls' => :build
  depends_on 'libnl3' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'linux_pam' => :library
  depends_on 'lz4' => :executable
  depends_on 'lzo' => :executable
  depends_on 'mold' => :build
  depends_on 'openssl' => :executable
  depends_on 'py3_docutils' => :build

  run_tests
end
