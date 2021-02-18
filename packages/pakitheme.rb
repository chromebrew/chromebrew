require 'package'

class Pakitheme < Package
  description 'Automatically install your host GTK+ theme as a Flatpak'
  homepage 'https://github.com/refi64/pakitheme'
  version '1.0'
  compatibility 'all'
  source_url 'https://github.com/saltedcoffii/pakitheme/archive/1.0.tar.gz'
  source_sha256 '32446ecc73ae95d699d6e14e5fa3dc3a8b3a9cfae02457b2b7f38fdd7d7524f3'

  depends_on 'flatpak'

  def self.install
    system "mkdir #{CREW_DEST_PREFIX}/bin -pv"
    system "install -v ./pakitheme #{CREW_DEST_PREFIX}/bin/pakitheme"
  end
end
