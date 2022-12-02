require 'package'

class Py3_pyudev < Package
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  @_ver = '0.22'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/pyudev/pyudev.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-py3.11_armv7l/py3_pyudev-0.22-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-py3.11_armv7l/py3_pyudev-0.22-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-py3.11_i686/py3_pyudev-0.22-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-py3.11_x86_64/py3_pyudev-0.22-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2b692913f4eb613fde4186b5e87e23261a6b7ee5cc77688e7501d599152a346f',
     armv7l: '2b692913f4eb613fde4186b5e87e23261a6b7ee5cc77688e7501d599152a346f',
       i686: 'c9375db3629c85d56ffa78b57860d97f7352afe7b9ac64836d618ac03a98fdab',
     x86_64: '3f14169495c664e1d43ec87af8357e235b1eabd2137490fcffa154b4d21e42ce'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
