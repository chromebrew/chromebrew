require 'package'

class Py3_click < Package
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  @_ver = '8.0.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/click.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3_armv7l/py3_click-8.0.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3_armv7l/py3_click-8.0.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3_i686/py3_click-8.0.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.0.3_x86_64/py3_click-8.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bfc7bedff44e1ce578d2b317054b2e57d0c103ff2528d15e86c159df1c3b0175',
     armv7l: 'bfc7bedff44e1ce578d2b317054b2e57d0c103ff2528d15e86c159df1c3b0175',
       i686: '540eafa6139980fcd8cf223a49a80648777b109cdc78c5df28c115ae401a7e6b',
     x86_64: 'cbaec20a29da3198a93318e0d8bbde2842c8bbdf6bd96364b4fb1aa743749b17'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
