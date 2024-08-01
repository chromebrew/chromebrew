require 'package'

class Flif < Package
  description 'FLIF is a novel lossless image format which outperforms PNG, lossless WebP, lossless BPG, lossless JPEG2000, and lossless JPEG XR in terms of compression ratio.'
  homepage 'https://flif.info/'
  version '0.4'
  license 'LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FLIF-hub/FLIF.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6519ef5d2153c6cf3fc8afefba83d2cf91e5b574475aea741b9eab98fbaebc8a',
     armv7l: '6519ef5d2153c6cf3fc8afefba83d2cf91e5b574475aea741b9eab98fbaebc8a',
     x86_64: '34b5622953ad3e7595fc416270deed8882964e4addde5916bae110cff01ae6fb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libpng' # R
  depends_on 'libsdl2'

  # Upstream has stopped development, so there's no real reason to try and upstream these.
  def self.patch
    system "sed -i 's,\$(PREFIX)/lib,#{CREW_DEST_LIB_PREFIX},g' src/Makefile"
    system "sed -i 's,export LD_LIBRARY_PATH,#export LD_LIBRARY_PATH,' src/Makefile"
  end

  def self.build
    system 'make', 'all'
    Dir.chdir 'src' do
      system 'make', 'decoder'
      system 'make', 'viewflif'
    end
  end

  def self.install
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install'
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install-dev'
    Dir.chdir 'src' do
      system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install-decoder'
      system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install-viewflif'
    end
  end
end
