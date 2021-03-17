require 'package'

class Poppler_data < Package
  description 'This additional package consists of encoding files for use with Poppler.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '0.4.10'
  version @_ver
  compatibility 'all'
  source_url "https://poppler.freedesktop.org/poppler-data-#{@_ver}.tar.gz"
  source_sha256 '6e2fcef66ec8c44625f94292ccf8af9f1d918b410d5aa69c274ce67387967b30'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.10-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '819a39d253b0e62d9e08f704e9d8d9bc551f48528393a82d988d87a64422ec63',
     armv7l: '819a39d253b0e62d9e08f704e9d8d9bc551f48528393a82d988d87a64422ec63',
       i686: '5982a173cc1a37ad97c0e5a79089e09ed9558acd11163d322b1b964dbf232d9b',
     x86_64: '129a2d18480c9074f52a3bd2560f4fede057c065ec9823908c12f62b7c42bf20'
  })

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
