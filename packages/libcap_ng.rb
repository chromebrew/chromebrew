require 'package'

class Libcap_ng < Package
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.7.8-0'
  compatibility 'all'
  source_url 'https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-0.7.8.tar.gz'
  source_sha256 'c21af997445cd4107a55d386f955c5ea6f6e96ead693e9151277c0ab5f97d05f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '393c39c06fa807c9d879fbf97a50f95ad94741f2a64ea79306181026df057208',
     armv7l: '393c39c06fa807c9d879fbf97a50f95ad94741f2a64ea79306181026df057208',
       i686: '60bd85f01a320d59e114cab2ecae92c8bbe5a05552512ec0ef81cb9b792aea89',
     x86_64: 'ddf60e28ecb7fc3f60d6e2bfa47492ddfa9a09fff1b115634eb726901846304e',
  })

  depends_on 'python3'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
