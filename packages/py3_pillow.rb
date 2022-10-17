require 'package'

class Py3_pillow < Package
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  @_ver = '9.2.0'
  version @_ver
  license 'HPND'
  compatibility 'all'
  source_url 'https://github.com/python-pillow/Pillow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0_armv7l/py3_pillow-9.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0_armv7l/py3_pillow-9.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0_i686/py3_pillow-9.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0_x86_64/py3_pillow-9.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a7dca84ba66e922f09d1228359603b4ccb100e942cc94b54c6403762631f64ad',
     armv7l: 'a7dca84ba66e922f09d1228359603b4ccb100e942cc94b54c6403762631f64ad',
       i686: '1bc978b4feb8e36f5adfcd39ed70f617e1b3e1687aa4c427aadf75c771505f69',
     x86_64: 'dd1671f31ece4b7524ff8c4750b0d4c014e5558c0f12ddb2def2c1195bfeabb6'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'libjpeg'
  depends_on 'libxcb'
  depends_on 'py3_setuptools' => :build
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'lcms' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'openjpeg' # R
  depends_on 'zlibpkg' # R

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
