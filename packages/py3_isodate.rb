require 'package'

class Py3_isodate < Package
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  @_ver = '0.6.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate.git'
  git_hashtag @_ver

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
