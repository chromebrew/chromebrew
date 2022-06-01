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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.2_i686/py3_pillow-8.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.2_x86_64/py3_pillow-8.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9fce3158f591eee0da9cfd23ba016bf7511428f32e06a4e11a260cbdd56cd2d3',
     armv7l: '9fce3158f591eee0da9cfd23ba016bf7511428f32e06a4e11a260cbdd56cd2d3',
       i686: 'cd5a42a14c747c0a0de485e97789100b6dc29ac577f8c996f50cd77e2399a267',
     x86_64: '44bd4009526b8f531b1dc4f67cc9fa2aa675d195b9f37ef47b71855238ec7da3'
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
