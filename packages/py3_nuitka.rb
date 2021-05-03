require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.14.5'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.14.5_armv7l/py3_nuitka-0.6.14.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.14.5_armv7l/py3_nuitka-0.6.14.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.14.5_i686/py3_nuitka-0.6.14.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.14.5_x86_64/py3_nuitka-0.6.14.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '342295e624e2ff25e398c14661d8fda9088c3a49fa6dc5ca10f9b6f4832723ee',
     armv7l: '342295e624e2ff25e398c14661d8fda9088c3a49fa6dc5ca10f9b6f4832723ee',
       i686: '536aa48fba66c1dea2f81127479426be5edbd9b21336b44d415ba635be69b17d',
     x86_64: '36d1e314d0ea9c9777819ced374c21a3d7d36e8e14435d5f45a687d26b490adb'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
