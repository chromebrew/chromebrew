require 'buildsystems/autotools'

class Openvpn < Autotools
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.7.9'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/OpenVPN/openvpn.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a78cf0d6a5be57a4438af0c7594fb89a9622d3ae5384b87539742901bd4f85b',
     armv7l: '8a78cf0d6a5be57a4438af0c7594fb89a9622d3ae5384b87539742901bd4f85b',
     x86_64: '656b1b389110471945df217492d754c8d61c12b129c09ff36615edff17b0a473'
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
