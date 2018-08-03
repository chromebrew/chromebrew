require 'package'

class dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr'
  version '1.0-cros'
  source_url 'https://codeload.github.com/Ewpratten/dr/tar.gz/1.0-chr'
  source_sha256 '3e7b33bec353b23132db365e5bacd175361d1e9039544e5e64b8df8c7e828006'

  depends_on 'python3'

  def self.build
    system "cd build/"
    system 'sh ./build-cros.sh'
  end

  def self.install
    system "which dr"
  end
end
