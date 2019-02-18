require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  version '3.42'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_42_RTM/src/nss-3.42-with-nspr-4.20.tar.gz'
  source_sha256 '59a0f6f4209b4066702c20c75d6b5531c92b6b3a7bc938b56aa3891c808860dd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.42-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.42-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.42-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9181501ed99d339989be2aaa11fe69cc0a5317b13bfadf95e6924d497e8d13c7',
     armv7l: '9181501ed99d339989be2aaa11fe69cc0a5317b13bfadf95e6924d497e8d13c7',
       i686: '69644e80b3127dcfc4a20e3353dd194297c427c9a37bbbbae1a9482c9cb45961',
     x86_64: 'b7444bf704022a0bf2f6efe785bbf65b5ed12479a0c1d03e89500b1d19652e00',
  })

  depends_on 'gyp' => :build
  depends_on 'meson' => :build
  depends_on 'nspr'
  depends_on 'sqlite'

  def self.build
    Dir.chdir 'nss' do
      system "CPPFLAGS='-I#{CREW_PREFIX}/include/nspr' ./build.sh --opt --gcc --system-nspr --system-sqlite"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    system "mv dist/Release/lib dist/Release/#{ARCH_LIB}" unless "#{ARCH_LIB}" == "lib"
    system "cp -a dist/Release/* #{CREW_DEST_PREFIX}"
  end
end
