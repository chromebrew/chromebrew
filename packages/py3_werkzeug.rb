require 'package'

class Py3_werkzeug < Package
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  @_ver = '2.0.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/werkzeug.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_armv7l/py3_werkzeug-2.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_armv7l/py3_werkzeug-2.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_i686/py3_werkzeug-2.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_x86_64/py3_werkzeug-2.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '26e8b86c9038a994d0be11a9dbb120b182663911f50a8eda383c096f076b6556',
     armv7l: '26e8b86c9038a994d0be11a9dbb120b182663911f50a8eda383c096f076b6556',
       i686: '585c00685237b65a4cdc28eda8682364cfbbe75390ca7db6e51a315a73f73269',
     x86_64: '6a9b20165cb9a7f3840c1cd3afc78cb3722f111259762011ef05fe37c48d6801'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
