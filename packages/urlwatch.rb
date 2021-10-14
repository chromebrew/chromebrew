require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  @_ver = '2.23'
  version "#{@_ver}-2"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch.git'
  git_hashtag @_ver

  depends_on 'py3_lxml'
  depends_on 'py3_cssselect'
  depends_on 'py3_minidb'
  depends_on 'py3_pyyaml'
  depends_on 'py3_requests'
  depends_on 'py3_appdirs'
  depends_on 'py3_keyring'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
