require 'package'

class Py3_virtualenv < Package
  description 'Virtualenv is a Virtual Python Environment builder.'
  homepage 'http://virtualenv.pypa.io/'
  version '20.4.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/f4/6d/bfcfff1709d05143e71337db4800b30dd9abf0c41972960c9e8984ab96f7/virtualenv-20.4.3.tar.gz'
  source_sha256 '49ec4eb4c224c6f7dd81bb6d0a28a09ecae5894f4e593c89b0db0885f565a107'

  depends_on 'py3_appdirs'
  depends_on 'py3_distlib'
  depends_on 'py3_filelock'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
