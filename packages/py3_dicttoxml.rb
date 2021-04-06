require 'package'

class Py3_dicttoxml < Package
  description 'Dicttoxml converts a Python dictionary or other native data type into a valid XML string.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  version '1.7.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/74/36/534db111db9e7610a41641a1f6669a964aacaf51858f466de264cc8dcdd9/dicttoxml-1.7.4.tar.gz'
  source_sha256 'ea44cc4ec6c0f85098c57a431a1ee891b3549347b07b7414c8a24611ecf37e45'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
