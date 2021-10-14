require 'package'

class Py3_dateutil < Package
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  @_ver = '2.8.2'
  version @_ver
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
