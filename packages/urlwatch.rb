require 'package'

class Urlwatch < Package
  description 'urlwatch helps you watch changes in webpages.'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.22'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch/archive/2.22.tar.gz'
  source_sha256 '951148da670777541a4698c9e6cf46d20c15d4982815bbac17dfb2af64ce9e06'

  depends_on 'py3_pyyaml'
  depends_on 'py3_minidb'
  depends_on 'py3_requests'
  depends_on 'py3_keyring'
  depends_on 'py3_appdirs'
  depends_on 'py3_chump'
  depends_on 'py3_pushbullet_py'
  depends_on 'py3_pycodestyle'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
