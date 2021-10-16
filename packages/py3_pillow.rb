require 'package'

class Py3_pillow < Package
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  @_ver = '8.3.2'
  version @_ver
  license 'HPND'
  compatibility 'all'
  source_url 'https://github.com/python-pillow/Pillow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.2_armv7l/py3_pillow-8.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.2_armv7l/py3_pillow-8.3.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.2_x86_64/py3_pillow-8.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0aa75be0dba67b13e2e2016dc86953a2bc56d9d6a8c261f675045121a281e37d',
     armv7l: '0aa75be0dba67b13e2e2016dc86953a2bc56d9d6a8c261f675045121a281e37d',
     x86_64: '0bb3b009e7c3ba3df74efeab479f65203f0e6d452f0fa246eb8963aeb7f7d746'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'libjpeg'
  depends_on 'libxcb'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build_ext \
            --disable-platform-guessing \
            --enable-zlib \
            --enable-jpeg \
            --enable-xcb"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
