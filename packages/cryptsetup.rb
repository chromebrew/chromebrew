require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.8.8'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v#{version.sub(/\.\d+$/, '')}/cryptsetup-#{version}.tar.xz"
  source_sha256 '3acfa685f2dd7fcc832e0b77bc7093aa7da554a51ce8dafbb4138eaa854eee35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d71490ef7064b9130c419f2ca84c616f603cd4882f5b8fd1cf517364eade7e3',
     armv7l: '7d71490ef7064b9130c419f2ca84c616f603cd4882f5b8fd1cf517364eade7e3',
       i686: '90c348d457d030e9be33f0c6a9e0bae51c3752a87e3bbd8f18ef20667d13ffda',
     x86_64: 'ea79114c241954483341e3199deab8c62f12ee8c864fddfe1ef0a627ec570805'
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
