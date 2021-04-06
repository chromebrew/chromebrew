require 'package'

class Py3_pycairo < Package
  description 'Pycairo is a Python module providing bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version '1.20.0'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/9d/6e/499d6a6db416eb3cdf0e57762a269908e4ab6638a75a90972afc34885b91/pycairo-1.20.0.tar.gz'
  source_sha256 '5695a10cb7f9ae0d01f665b56602a845b0a8cb17e2123bfece10c2e58552468c'

  depends_on 'cairo'
  depends_on 'python3'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
