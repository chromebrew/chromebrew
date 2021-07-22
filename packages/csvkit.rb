require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.rtfd.org/'
  @_ver = '1.0.6'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/csvkit.git'
  git_hashtag @_ver

  depends_on 'py3_six'
  depends_on 'py3_agate_dfb'
  depends_on 'py3_agate'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
