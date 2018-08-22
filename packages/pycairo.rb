require 'package'

class Pycairo < Package
  description 'Pycairo is a Python module providing bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version '1.17.1'
  source_url 'https://files.pythonhosted.org/packages/68/76/340ff847897296b2c8174dfa5a5ec3406e3ed783a2abac918cf326abad86/pycairo-1.17.1.tar.gz'
  source_sha256 '0f0a35ec923d87bc495f6753b1e540fd046d95db56a35250c44089fbce03b698'

  depends_on 'cairo'
  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
