require 'package'

class Madplay < Package
  description 'Decode and play MPEG audio files'
  homepage 'https://www.underbit.com/products/mad/'
  version '0.15.2b'
  compatibility 'all'
  source_url 'ftp://ftp.mars.org/pub/mpeg/madplay-0.15.2b.tar.gz'
  source_sha256 '5a79c7516ff7560dffc6a14399a389432bc619c905b13d3b73da22fa65acede0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/madplay-0.15.2b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/madplay-0.15.2b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/madplay-0.15.2b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/madplay-0.15.2b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd13a87ad6db7d64ad099815c35bf34b05724068699283abe79d7bceff1831df3',
     armv7l: 'd13a87ad6db7d64ad099815c35bf34b05724068699283abe79d7bceff1831df3',
       i686: '140e4c39b9cb08c6fe453012fa737cc1895494711705ab0c42d0e503f1a018c8',
     x86_64: 'e24353e4a61f0b8d5e4a8fda4bc2d5a3d3e94f55147aa666e2f271b1e7671900',
  })

  depends_on 'libmad'
  depends_on 'libid3tag'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
