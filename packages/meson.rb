require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.44.0'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.44.0/meson-0.44.0.tar.gz'
  source_sha256 '50f9b12b77272ef6ab064d26b7e06667f07fa9f931e6a20942bba2216ba4281b'
  
  depends_on 'python3'
  depends_on 'ninja'

  def self.install
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} meson"
  end
end
