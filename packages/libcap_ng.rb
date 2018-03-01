require 'package'

class Libcap_ng < Package
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.7.8'
  source_url 'https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-0.7.8.tar.gz'
  source_sha256 'c21af997445cd4107a55d386f955c5ea6f6e96ead693e9151277c0ab5f97d05f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap_ng-0.7.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cd1732e027451fbfdcd3122cc69f4b578ed19dad65a1c7e9a6d13cfce14a4fa0',
     armv7l: 'cd1732e027451fbfdcd3122cc69f4b578ed19dad65a1c7e9a6d13cfce14a4fa0',
       i686: 'fc643bc135bb62067bf7a15ac9cebc960caa09b105a99efd71029746c5159da9',
     x86_64: 'b960b5a73ee60009e09b6b5c4f50dab6e8838939a76ebf6849a2e04a36ca5855',
  })

  depends_on 'python3'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
