require 'buildsystems/autotools'

class Which < Autotools
  description 'which shows the full path of (shell) commands.'
  homepage 'https://carlowood.github.io/which/'
  version '2.25'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/which/which-#{version}.tar.gz"
  source_sha256 '1cb83e4f702e60b8211ab5ec4c2afbab1b1dec80209456a7d2faf7584ed225ea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '127544938512691f63f358e53c136e2eca807a28d2b0b2cf2b59c4e277b0ed1b',
     armv7l: '127544938512691f63f358e53c136e2eca807a28d2b0b2cf2b59c4e277b0ed1b',
       i686: '0d4306150b53d7be7596d8508d1bac46b01fe992e334e3af8d321b1127b3e70d',
     x86_64: 'e6cdafbd3662f7d8ada1f80abe7af329c9fb0645afb6e3007ed5047c654b7d5c'
  })

  depends_on 'glibc' => :executable
end
