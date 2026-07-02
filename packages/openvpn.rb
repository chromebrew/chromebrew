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
    aarch64: 'd222539df6252c5cc3edafef82547096ed12e41a039e1aabe447ba55aa36bc83',
     armv7l: 'd222539df6252c5cc3edafef82547096ed12e41a039e1aabe447ba55aa36bc83',
     x86_64: '521fe88dc72e261722135f40c436d9bd5d37617e9b13b11889597567dee291ab'
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
