require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.8.9'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v#{version.sub(/\.\d+$/, '')}/cryptsetup-#{version}.tar.xz"
  source_sha256 '8667085a4f59174928948b501b4a2a68f7f1cce1cfe46170b8f40fa6534742b3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd403e6abcf237b8d2e79d4967fa36e4cdc689d9187674593da0d97aec63bab64',
     armv7l: 'd403e6abcf237b8d2e79d4967fa36e4cdc689d9187674593da0d97aec63bab64',
       i686: '059b5f3693f52ed5cabe1fddd865c24ed9e0bce7ba2edaf61273e9ec284da9c7',
     x86_64: '6341d3190a9e06d1689020f53de7b166ad3481663a823bc24ad19558e9260f23'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'json_c' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libssh' => :library
  depends_on 'lvm2' => :library
  depends_on 'openssl' => :library
  depends_on 'popt' => :executable
  depends_on 'util_linux' => :library

  autotools_configure_options '--disable-asciidoc'
end
