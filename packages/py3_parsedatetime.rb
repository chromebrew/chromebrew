require 'package'

class Py3_parsedatetime < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
