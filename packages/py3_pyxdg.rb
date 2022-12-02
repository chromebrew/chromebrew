require 'package'

class Py3_pyxdg < Package
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  @_ver = '0.28'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/takluyver/pyxdg.git'
  git_hashtag "rel-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyxdg/0.28-py3.11_armv7l/py3_pyxdg-0.28-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyxdg/0.28-py3.11_armv7l/py3_pyxdg-0.28-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyxdg/0.28-py3.11_i686/py3_pyxdg-0.28-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyxdg/0.28-py3.11_x86_64/py3_pyxdg-0.28-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cb0000fd9d0c07700b63256f3c48b3e1a2b172a7169ccb5f60552067d78fedfe',
     armv7l: 'cb0000fd9d0c07700b63256f3c48b3e1a2b172a7169ccb5f60552067d78fedfe',
       i686: '65692757bc5c6624a037b223edf738ce861a5fba9eea5bc05f3c07a8184fd5c5',
     x86_64: 'da83893265d4bcfd96676abc00eb9ff63478f04918e3aae0fea53de580916950'
  })

  depends_on 'python3' => :build

  no_compile_needed

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
