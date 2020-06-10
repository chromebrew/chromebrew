require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  version '3.46'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_46_RTM/src/nss-3.46-with-nspr-4.22.tar.gz'
  source_sha256 '3d4197196e870ab2dccc6ee497e0ec83f45ea070fee929dd931491c024d69f31'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.46-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.46-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.46-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nss-3.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70857c150acf4e50ab20f1108c89c1be22189953ecbcabb13816d92d7473854f',
     armv7l: '70857c150acf4e50ab20f1108c89c1be22189953ecbcabb13816d92d7473854f',
       i686: '7693bc01a39e8a15a7f1a5c5be28194cdd65c2592155401952d14a8376b80ac5',
     x86_64: '5d15892323a46a0d4c4cf709f615e2243adb1ade44d7118773b3a057cf11aa9a',
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
