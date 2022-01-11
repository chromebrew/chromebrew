require 'package'

class Libdvbpsi < Package
  description 'libdvbpsi is a simple library designed for decoding and generation of MPEG TS and DVB PSI tables according to standards ISO/IEC 13818 and ITU-T H.222.0.'
  homepage 'https://www.videolan.org/developers/libdvbpsi.html'
  version '1.3.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.videolan.org/pub/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2'
  source_sha256 '02b5998bcf289cdfbd8757bedd5987e681309b0a25b3ffe6cebae599f7a00112'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-release"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
