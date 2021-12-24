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
    aarch64: '34f17a880636d0b48866f88c0683881bb0187812b1e61c7c8672681baadef560',
     armv7l: '34f17a880636d0b48866f88c0683881bb0187812b1e61c7c8672681baadef560',
       i686: 'f4e058e264f6d9531307f6afb507ad12bcaeb1bf892d1cff1bb2161f843e38b7',
     x86_64: '8ee1716bbec539ae57cc6fa25491f29979166bbc37882b6cb1bd8a473159e028'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
