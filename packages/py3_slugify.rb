require 'package'

class Py3_slugify < Package
  description 'Slugify is a generic slugifier utility for python.'
  homepage 'https://github.com/zacharyvoase/slugify'
  version '0.0.1'
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/7b/89/fbb7391d777b60c82d4e1376bb181b98e75adf506b3f7ffe837eca64570b/slugify-0.0.1.tar.gz'
  source_sha256 'c5703cc11c1a6947536f3ce8bb306766b8bb5a84a53717f5a703ce0f18235e4c'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
