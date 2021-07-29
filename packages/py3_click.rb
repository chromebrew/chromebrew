require 'package'

class Py3_click < Package
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  @_ver = '7.1.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/click.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/7.1.2_armv7l/py3_click-7.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/7.1.2_armv7l/py3_click-7.1.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/7.1.2_x86_64/py3_click-7.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '601e3274f08e2308083fc312aa4614b5eedb4272f611d344f77f72248abcd89f',
     armv7l: '601e3274f08e2308083fc312aa4614b5eedb4272f611d344f77f72248abcd89f',
     x86_64: 'baca766a2e97aeb8c6999fff28bc9b6f76493f544abd8e335ab502420e0544b0'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
