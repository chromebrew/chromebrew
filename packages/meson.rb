require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.55.3'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.55.3.tar.gz'
  source_sha256 '2b276df50c5b13ccdbfb14d3333141e9e7985aca31b60400b3f3e0be2ee6897e'

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
