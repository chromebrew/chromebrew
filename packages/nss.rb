require 'package'

class Nss < Package
  description 'Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS'
  version '3.59'
  compatibility 'all'
  source_url 'https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_59_RTM/src/nss-3.59-with-nspr-4.29.tar.gz'
  source_sha256 '2e2c09c17b1c9f43a2f0a5d83a30a712bff3016d2b7cf5a3dd904847292607ae'

  depends_on 'gyp' => :build
  depends_on 'meson' => :build
  depends_on 'nspr'
  depends_on 'sqlite'

  def self.build
    Dir.chdir 'nss' do
      system "CPPFLAGS='-I#{CREW_PREFIX}/include/nspr' ./build.sh --opt --gcc --system-nspr --system-sqlite --disable-tests"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/nss"
    system "rm dist/Release/lib/*.so.TOC"
    FileUtils.mv "dist/Release/lib","dist/Release/#{ARCH_LIB}" unless "#{ARCH_LIB}" == "lib"
    system "cp -a dist/Release/* #{CREW_DEST_PREFIX}"
    system "cp -a dist/public/nss/* #{CREW_DEST_PREFIX}/include/nss/"
  end
end
