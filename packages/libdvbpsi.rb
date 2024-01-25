require 'package'

class Libdvbpsi < Package
  description 'libdvbpsi is a simple library designed for decoding and generation of MPEG TS and DVB PSI tables according to standards ISO/IEC 13818 and ITU-T H.222.0.'
  homepage 'https://www.videolan.org/developers/libdvbpsi.html'
  version '1.3.3'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://download.videolan.org/pub/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2'
  source_sha256 '02b5998bcf289cdfbd8757bedd5987e681309b0a25b3ffe6cebae599f7a00112'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'd528cc96c1ad8867d0698447257ea2804e173a30b8dd0110b128353312f1c1a6',
      armv7l: 'd528cc96c1ad8867d0698447257ea2804e173a30b8dd0110b128353312f1c1a6',
        i686: '633ad6aaee5508dfc781e3768d108b947f32c1609079ccc14d97254fe0f795a5',
      x86_64: 'ff2fab5910127c762cc75c072fe30141b38f37ff90c29be5cef871250d688fd7'
  })

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
