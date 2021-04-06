require 'package'

class Py3_click < Package
  description 'Click creates beautiful command line interfaces.'
  homepage 'https://palletsprojects.com/p/click/'
  version '7.1.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/pallets/click/archive/7.1.2.tar.gz'
  source_sha256 'da626c7e5fa918a8c9bf9b5c0c0255b55469ca6b0c3cb2318ea0dc7eb05a56c3'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
