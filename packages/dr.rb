# Note: this package is depreciated upstream

require 'package'

class Dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr/'
  version '2.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_requests'
  depends_on 'py3_setuptools' => :build

  def self.install
    system 'curl -#Lo dr/dr https://github.com/Ewpratten/dr/releases/download/2.0-cros/dr'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('dr/dr') ) == '4e39a28f947ac044e28349fb10ffb423100fb00acb0ab819e931d931e3f0b02f'
    system "install -Dm755 dr/dr #{CREW_DEST_PREFIX}/bin/dr"
  end
end
