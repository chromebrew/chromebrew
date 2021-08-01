require 'package'

class Py3_pillow < Package
  description 'Pillow is a Python Imaging Library (PIL).'
  homepage 'https://python-pillow.org/'
  @_ver = '8.3.1'
  version @_ver
  license 'HPND'
  compatibility 'all'
  source_url 'https://github.com/python-pillow/Pillow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.1_armv7l/py3_pillow-8.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.1_armv7l/py3_pillow-8.3.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pillow/8.3.1_x86_64/py3_pillow-8.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd13c98552eb144e0e37550e179a49c24fe1a35a0a3033810e3814d32c0fbc015',
     armv7l: 'd13c98552eb144e0e37550e179a49c24fe1a35a0a3033810e3814d32c0fbc015',
     x86_64: '227408b4faf8bbb1dfe0da046d54dad9071d054cad675eba91468717ce438919'
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
