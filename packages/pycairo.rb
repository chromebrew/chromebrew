require 'package'

class Pycairo < Package
  description 'Pycairo is a Python module providing bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version '1.17.1'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/68/76/340ff847897296b2c8174dfa5a5ec3406e3ed783a2abac918cf326abad86/pycairo-1.17.1.tar.gz'
  source_sha256 '0f0a35ec923d87bc495f6753b1e540fd046d95db56a35250c44089fbce03b698'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pycairo-1.17.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pycairo-1.17.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pycairo-1.17.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pycairo-1.17.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '401ca3457234b15a392c6506480211a83c6d3d03b191e0dc1033cf8daacc341b',
     armv7l: '401ca3457234b15a392c6506480211a83c6d3d03b191e0dc1033cf8daacc341b',
       i686: '2921ce60149fdaef82bfde2e0eb4f661a40ce7a31ff8cd6b9bec3551c060611e',
     x86_64: '7805d36fa3e6377411f2c29cbbba4ca7148102d84cf31a1287ce5e6ca9ab7fb0',
  })

  depends_on 'cairo'
  depends_on 'python3'
  depends_on 'python27'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
