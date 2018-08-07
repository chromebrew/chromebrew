require 'package'

class Dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr'
  version '2.0'
  source_url 'https://github.com/Ewpratten/dr/archive/2.0-cros.tar.gz'
  source_sha256 '3e7b33bec353b23132db365e5bacd175361d1e9039544e5e64b8df8c7e828006'

  depends_on 'python3'

  def self.install
    system 'wget -O dr/dr https://github.com/Ewpratten/dr/releases/download/2.0-cros/dr'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('dr/dr') ) == 'c05d1b86f99927502b65b629ade165afe2c47090e991d34c61e570c062db070e'
    system "install -Dm755 dr/dr #{CREW_DEST_PREFIX}/bin/dr"
    system "pip3 install setuptools"
    system "pip3 install . --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} --upgrade --no-cache-dir -r requirements.txt"
  end
end
