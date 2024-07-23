require 'package'

class Flif < Package
  description 'FLIF is a novel lossless image format which outperforms PNG, lossless WebP, lossless BPG, lossless JPEG2000, and lossless JPEG XR in terms of compression ratio.'
  homepage 'https://flif.info/'
  version '0.3'
  license 'LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FLIF-hub/FLIF/archive/v0.3.tar.gz'
  source_sha256 'aa02a62974d78f8109cff21ecb6d805f1d23b05b2db7189cfdf1f0d97ff89498'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '64f447f5fe90b8075259e6bf427387b7baa64a6d0dd7bbc49c05325bc20cf882',
     armv7l: '64f447f5fe90b8075259e6bf427387b7baa64a6d0dd7bbc49c05325bc20cf882',
     x86_64: 'd07dff394d43d90cb2e9270be4886f9d922020cb5c65e566785dce5422759b2f'
  })

  depends_on 'libsdl2'

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
