require 'buildsystems/meson'

class Libkmod < Meson
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  version '34.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/kmod-project/kmod.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01389eaaeb72f0ab2dc125448660e938ab453eba4e426ad6cb181b2c8b099576',
     armv7l: '01389eaaeb72f0ab2dc125448660e938ab453eba4e426ad6cb181b2c8b099576',
       i686: 'd9cc3171ee84edfd3ede4af986561496c725d1a4263c15730068f361ee5bc4df',
     x86_64: '9db893c96661faf9faf2a2c00ace249e731de01e17e0272028cd9184321ba848'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'scdoc' => :build # Needed for manpages.
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R
end
