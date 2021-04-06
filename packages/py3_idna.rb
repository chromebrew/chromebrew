require 'package'

class Py3_idna < Package
  description 'idna provides support for the Internationalised Domain Names in Applications (IDNA) protocol in python'
  homepage 'https://github.com/kjd/idna/'
  version '3.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna/archive/v3.1.tar.gz'
  source_sha256 'c8797aafc49088abbc9ca413e8be85888f474ca66f94c99796db46cb257f5e7f'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
