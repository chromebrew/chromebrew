require 'package'

class Dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr'
  version '2.0'
  compatibility 'all'
  source_url 'https://github.com/Ewpratten/dr/archive/2.0-cros.tar.gz'
  source_sha256 '0ab9003c23d74d1ca8b0cfaf33e7db5e5b908d3448c87c4c0a83c9bf77a8ac23'

  depends_on 'setuptools'

  def self.install
    system 'wget -O dr/dr https://github.com/Ewpratten/dr/releases/download/2.0-cros/dr'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('dr/dr') ) == '4e39a28f947ac044e28349fb10ffb423100fb00acb0ab819e931d931e3f0b02f'
    system "install -Dm755 dr/dr #{CREW_DEST_PREFIX}/bin/dr"
    system "pip3 install . --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} --upgrade --no-cache-dir -r requirements.txt"
  end
end
