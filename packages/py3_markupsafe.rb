require 'package'

class Py3_markupsafe < Package
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_i686/py3_markupsafe-2.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_x86_64/py3_markupsafe-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '88b79d1954f17a711dc7e5ef4af4b215d3b5f3648e5321f6e94be7787334c127',
     armv7l: '88b79d1954f17a711dc7e5ef4af4b215d3b5f3648e5321f6e94be7787334c127',
       i686: 'caff6c801d1fe95917b88e08e5593d322aa10cf8b79e1592f0fecf964f29855f',
     x86_64: '0f7dbc0ac9261efa659c7d8eba7866c845242329b0ddd1403f4b2bbfdf3d0ef7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
