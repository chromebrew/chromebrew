require 'package'

class Fortunes < Package
  description 'Over 15000 cookies for the fortune program.'
  homepage 'https://packages.debian.org/sid/fortunes'
  version '1.99.1'
  compatibility 'all'
  source_url 'http://cdn-fastly.deb.debian.org/debian/pool/main/f/fortune-mod/fortune-mod_1.99.1.orig.tar.gz'
  source_sha256 'fc51aee1f73c936c885f4e0f8b6b48f4f68103e3896eaddc6a45d2b71e14eace'

  depends_on 'fortune'

  def self.install
    system "mkdir -pv #{CREW_DEST_PREFIX}/share/games/fortunes"
    system "mv datfiles/* #{CREW_DEST_PREFIX}/share/games/fortunes/"
  end
end
