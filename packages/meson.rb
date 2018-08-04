require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.47.1'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.47.1/meson-0.47.1.tar.gz'
  source_sha256 'd673de79f7bab064190a5ea06140eaa8415efb386d0121ba549f6d66c555ada6'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'ninja'
  depends_on 'python3'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
