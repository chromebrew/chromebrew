require 'package'

class Dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr'
  version '2.0'
  source_url 'https://github.com/Ewpratten/dr/archive/2.0-cros.tar.gz'
  source_sha256 '4e39a28f947ac044e28349fb10ffb423100fb00acb0ab819e931d931e3f0b02f'

  depends_on 'python3'

  def self.install
    system 'wget -O dr/dr https://github.com/Ewpratten/dr/releases/download/2.0-cros/dr'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('dr/dr') ) == '4e39a28f947ac044e28349fb10ffb423100fb00acb0ab819e931d931e3f0b02f'
    system "install -Dm755 dr/dr #{CREW_DEST_PREFIX}/bin/dr"
    system "pip3 install setuptools"
    system "pip3 install . --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} --upgrade --no-cache-dir -r requirements.txt"
  end
end
