require 'package'

class Py3_pillow < Package
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  @_ver = '9.2.0'
  version "#{@_ver}-py3.11"
  license 'HPND'
  compatibility 'all'
  source_url 'https://github.com/python-pillow/Pillow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0-py3.11_armv7l/py3_pillow-9.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0-py3.11_armv7l/py3_pillow-9.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0-py3.11_i686/py3_pillow-9.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/9.2.0-py3.11_x86_64/py3_pillow-9.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dae86150cfd6bbeae44bb91ef6c74d39323559f0abd3ad7f839a1603df4a9ddc',
     armv7l: 'dae86150cfd6bbeae44bb91ef6c74d39323559f0abd3ad7f839a1603df4a9ddc',
       i686: 'b9a56506e4704e8d9a8077c6767c15d53cd41970749e7d3a99a1b21e11f46b7b',
     x86_64: 'bfbdbaf6614df85dc23199fb358b06dc455f8c0372b6b382dcd4b38fa43eed5d'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_xlsxwriter'
  depends_on 'libjpeg'
  depends_on 'libxcb'
  depends_on 'python3' => :build
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
