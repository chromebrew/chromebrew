require 'package'

class Py3_pycparser < Package
  description 'Pycparser is a complete C99 parser written in pure python.'
  homepage 'https://github.com/eliben/pycparser/'
  version '2.20'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/eliben/pycparser/archive/release_v2.20.tar.gz'
  source_sha256 '1b895b4f6fb5195ce9c516ca7e28c9bd2f9ecd0f02755302b8a717454abea806'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
