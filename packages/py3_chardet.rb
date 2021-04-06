require 'package'

class Py3_chardet < Package
  description 'Chardet is a universal encoding detector for Python.'
  homepage 'https://github.com/chardet/chardet/'
  version '4.0.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/chardet/chardet/archive/4.0.0.tar.gz'
  source_sha256 '67bbe3eb02691d38831ddf2719c40fe09381bc17f15321946f6cd71dc274e530'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
