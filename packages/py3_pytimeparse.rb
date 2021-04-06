require 'package'

class Py3_pytimeparse < Package
  description 'Pytimeparse is a small Python library to parse various kinds of time expressions.'
  homepage 'https://github.com/wroberts/pytimeparse/'
  version '1.1.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse/releases/download/1.1.8/pytimeparse-1.1.8.tar.gz'
  source_sha256 'e86136477be924d7e670646a98561957e8ca7308d44841e21f5ddea757556a0a'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
