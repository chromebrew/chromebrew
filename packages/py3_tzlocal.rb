require 'package'

class Py3_tzlocal < Package
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  @_ver = '3.0' # Check for updates soon. Prereleases for 4.0 are already out.
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/regebro/tzlocal.git'
  git_hashtag @_ver

  depends_on 'py3_pytz'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
