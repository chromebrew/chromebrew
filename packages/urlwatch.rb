require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  @_ver = '2.23'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch.git'
  git_hashtag @_ver

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/urlwatch/2.23-1_x86_64/urlwatch-2.23-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: 'a97f63ace9100a68c71a6c1cada31a65ed47d695367fe6cfff433141f8dffd17'
  })

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
