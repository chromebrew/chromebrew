require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.16.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.14.5_i686/py3_nuitka-0.6.14.5-chromeos-i686.tar.xz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.16.2_armv7l/py3_nuitka-0.6.16.2-chromeos-armv7l.tpxz',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.16.2_armv7l/py3_nuitka-0.6.16.2-chromeos-armv7l.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.16.2_x86_64/py3_nuitka-0.6.16.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '536aa48fba66c1dea2f81127479426be5edbd9b21336b44d415ba635be69b17d',
 aarch64: '06d9d1e0de011c0ebf250cfb71067c189210711480c08fb706185fe5f003d8ca',
  armv7l: '06d9d1e0de011c0ebf250cfb71067c189210711480c08fb706185fe5f003d8ca',
  x86_64: 'f647a197723b43ec25f57bcb03d6e05f41276f40424e1e3c0f221602dfe7c721'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
