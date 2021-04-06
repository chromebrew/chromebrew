require 'package'

class Py3_decorator < Package
  description 'Decorator makes it easy to define signature-preserving function decorators and decorator factories.'
  homepage 'https://github.com/micheles/decorator/'
  version '4.4.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/micheles/decorator/archive/4.4.2.tar.gz'
  source_sha256 '5f53613d90a820df490ffeb782a66910dd992d31434aaa5f610ac7e0817d3822'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
