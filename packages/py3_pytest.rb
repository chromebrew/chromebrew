require 'package'

class Py3_pytest < Package
  description 'The pytest framework makes it easy to write small, scalable tests in Python.'
  homepage 'https://docs.pytest.org/'
  version '6.2.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/9e/1f/226f5c2393701c87c315b6d6cdb65ec1cbc9008e7a9ccb1d31ab79e0c19b/pytest-6.2.3.tar.gz'
  source_sha256 '671238a46e4df0f3498d1c3270e5deb9b32d25134c99b7d75370a68cfbe9b634'

  depends_on 'py3_attrs'
  depends_on 'py3_iniconfig'
  depends_on 'py3_pluggy'
  depends_on 'py3_packaging'
  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
