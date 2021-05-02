require 'package'

class Py3_psutil < Package
  description 'Legacy compatibility packages.'
  homepage 'https://github.com/giampaolo/psutil/'
  @_ver = '5.8.0'
  version '5.8.0-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil.git'
  git_hashtag "release-#{@_ver}"

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
