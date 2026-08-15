require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.23.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de77490c7469ad315fe9a9861bf325aa88ce10f7a415e1e67a3827b652f4b526',
     armv7l: 'de77490c7469ad315fe9a9861bf325aa88ce10f7a415e1e67a3827b652f4b526',
       i686: '03a2eba205b3b651fdfbd8508d39b323721ee82299d9c09d942a9b265b7a77fd',
     x86_64: 'e24aec82a141e1e1ecb9b82b58946f309130752e46e14412436ecea97f0aa11f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libidn2' => :library
  depends_on 'libunistring' => :library

  def self.patch
    # Update the PSL during build.
    downloader 'https://github.com/publicsuffix/list/raw/refs/heads/main/public_suffix_list.dat', 'SKIP', 'list/public_suffix_list.dat'
  end
end
