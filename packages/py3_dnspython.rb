require 'package'

class Py3_dnspython < Package
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  @_ver = '2.1.0'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
