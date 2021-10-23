require 'package'

class Py3_pyte < Package
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.0'
  version "#{@_ver}-1"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_armv7l/py3_pyte-0.8.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_armv7l/py3_pyte-0.8.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_i686/py3_pyte-0.8.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-1_x86_64/py3_pyte-0.8.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65de6acc83f8f8e323a4c7b91cfd6d93c35f93de9f79a6d0b335d3bff2282cca',
     armv7l: '65de6acc83f8f8e323a4c7b91cfd6d93c35f93de9f79a6d0b335d3bff2282cca',
       i686: 'b71466ea1913b1a3ad0d6ca123d54174fd16288cdccc095fdf9d55acefa80c06',
     x86_64: '139b6e39bd3a45a6f25d73e78f06d4f267602871c0bb246bdae9a1cc0db232ef'
  })

  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
