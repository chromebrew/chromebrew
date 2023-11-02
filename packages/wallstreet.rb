require 'package'

class Wallstreet < Package
  description 'Fill your console with Wall Street-like news and stats.'
  homepage 'https://a.hollywood.computer/'
  version '1.21'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/h/hollywood/hollywood_1.21.orig.tar.gz'
  source_sha256 '793ef1f022b376e131c75e05ff1b55a010c0f4193225bb79018855cb9ab89acb'

  # Wallstreet doesn't need binaries

  depends_on 'byobu'
  depends_on 'libcaca'
  depends_on 'newsboat'
  depends_on 'ticker'
  depends_on 'wget2'
  depends_on 'w3m'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cp './bin/wallstreet', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp_r './lib/wallstreet/', "#{CREW_DEST_PREFIX}/lib/"
    FileUtils.cp_r './share/wallstreet/', "#{CREW_DEST_PREFIX}/share/"
    FileUtils.cp './share/man/man1/wallstreet.1', "#{CREW_DEST_MAN_PREFIX}/man1/"
  end
end
