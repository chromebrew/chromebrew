require 'package'

class Daq < Package
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '2.0.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz'
  source_sha256 'd1f6709bc5dbddee3fdf170cdc1e49fb926e2031d4869ecf367a8c47efc87279'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8350c5c96bdb011e2cffc6a5b217fd9d56fccfa7686ee95eb4c3553a927983d9',
     armv7l: '8350c5c96bdb011e2cffc6a5b217fd9d56fccfa7686ee95eb4c3553a927983d9',
       i686: 'b390dedcfbe3465e2ae9396246c74f12c53de573b212767c062c63c5b842a6c7',
     x86_64: 'a91c2f6bac768394669178837bbf9491b359e79e4b0aa2843af80ad0796bdf8e'
  })

  depends_on 'libpcap'

  def self.patch
    system 'filefix' # Fix /usr/bin/file: No such file or directory
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
