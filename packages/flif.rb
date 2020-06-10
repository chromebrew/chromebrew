require 'package'

class Flif < Package
  description 'FLIF is a novel lossless image format which outperforms PNG, lossless WebP, lossless BPG, lossless JPEG2000, and lossless JPEG XR in terms of compression ratio.'
  homepage 'https://flif.info/'
  version '0.3'
  compatibility 'all'
  source_url 'https://github.com/FLIF-hub/FLIF/archive/v0.3.tar.gz'
  source_sha256 'aa02a62974d78f8109cff21ecb6d805f1d23b05b2db7189cfdf1f0d97ff89498'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/flif-0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/flif-0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/flif-0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/flif-0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '64f447f5fe90b8075259e6bf427387b7baa64a6d0dd7bbc49c05325bc20cf882',
     armv7l: '64f447f5fe90b8075259e6bf427387b7baa64a6d0dd7bbc49c05325bc20cf882',
       i686: '660419c699e79a045f92075c671a7a92c905d151cd82437c9b55bedddd4fba1a',
     x86_64: 'd07dff394d43d90cb2e9270be4886f9d922020cb5c65e566785dce5422759b2f',
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
