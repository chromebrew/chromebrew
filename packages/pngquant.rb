require 'package'

class Pngquant < Package
  description 'Command-line utility and a library for lossy compression of PNG images.'
  homepage 'https://pngquant.org/'
  version '3.0.3'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/kornelski/pngquant.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e67540255c0f2a15c976d6bb2e86169c908e819131070fef8441e801e17d7fa4',
     armv7l: 'e67540255c0f2a15c976d6bb2e86169c908e819131070fef8441e801e17d7fa4',
       i686: 'c5e5aa614d34e8301da3268d8d13e937722c86f85a4c7dec97eee01ec21827fa',
     x86_64: '69dde5daddc35d3c251d639361c5b07cdd75db4feeef7aa5f19c9e366a92740b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lcms' => :build
  depends_on 'libpng' # R
  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release --features=lcms2'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/pngquant', "#{CREW_DEST_PREFIX}/bin/pngquant", mode: 0o755
  end
end
