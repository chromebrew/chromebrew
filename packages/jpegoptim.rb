require 'buildsystems/autotools'

class Jpegoptim < Autotools
  description 'Utility to optimize/compress JPEG files'
  homepage 'https://github.com/tjko/jpegoptim'
  version '1.5.6'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/tjko/jpegoptim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c6e44e4ced81e9c727cec6e4e67388193baf9d0080c61b52b939f433b8eb26b',
     armv7l: '3c6e44e4ced81e9c727cec6e4e67388193baf9d0080c61b52b939f433b8eb26b',
       i686: 'db69dbb9747a28806678d54618de75c236b1d7c4c8f0c6031f78657ff449477e',
     x86_64: '809fcd8a7778d7bc519e09a2188785280717708ca12dd96b4cca1acdb2676df3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libjpeg_turbo' => :executable
end
