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
    aarch64: '3f90fc3f99dbf166e38d26579032472a2ffe0d39755ca857ba20fa55fb7bfa7e',
     armv7l: '3f90fc3f99dbf166e38d26579032472a2ffe0d39755ca857ba20fa55fb7bfa7e',
     x86_64: '3138b9b905278f7bd2bac7afaf6a601f2d9cd95f5c63955521b4b4b257708e19'
  })

  depends_on 'e2fsprogs' => :executable
  depends_on 'glibc' => :library
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
