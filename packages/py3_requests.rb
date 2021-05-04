require 'package'

class Py3_requests < Package
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  @_ver = '2.25.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/psf/requests.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
