require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.7.6'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5f36a1531ab46057627c9defb562f54c527d6802905730fd55ae736605a234a',
     armv7l: 'c5f36a1531ab46057627c9defb562f54c527d6802905730fd55ae736605a234a',
     x86_64: '4c992a4338d693b6533f4d7e2281c835ea5a1ee466f0b960ddf6ac2b9ecfec7b'
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
