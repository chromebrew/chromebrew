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
    aarch64: '9e4f7a4d8d8e1b8d0cc3a2d201939223acec8a03e94a42d6ae1e8a01034aa6c0',
     armv7l: '9e4f7a4d8d8e1b8d0cc3a2d201939223acec8a03e94a42d6ae1e8a01034aa6c0',
       i686: '517d96c4e8ca397ecacc5ae7844c7caed4acb45053e3ecdeda35569eae034832',
     x86_64: '034a8bcea83d704926b0af9a7b8595810d02daa2d601e73dacdbb511638dccf2'
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
