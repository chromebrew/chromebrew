require 'package'

class dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr'
  version '1.0-cros'
  source_url 'https://github.com/Ewpratten/dr/archive/1.0-chr.tar.gz'
  source_sha256 '3e7b33bec353b23132db365e5bacd175361d1e9039544e5e64b8df8c7e828006'

  depends_on 'python3'

  def self.build
    Dir.chdir 'build' do
    system 'sh ./build-cros.sh'
  end
  end

  def self.install
    system "which dr"
  end
end
