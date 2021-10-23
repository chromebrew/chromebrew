require 'package'

class Py3_agate < Package
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  @_ver = '1.6.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_armv7l/py3_agate-1.6.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_armv7l/py3_agate-1.6.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_i686/py3_agate-1.6.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_x86_64/py3_agate-1.6.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6e6b403c6ed355e682bf6a049f1ff33e35a341e3e94ceb03cd461f281ed1ccc7',
     armv7l: '6e6b403c6ed355e682bf6a049f1ff33e35a341e3e94ceb03cd461f281ed1ccc7',
       i686: '01e4f4dcdea767b5112e06039e7eb78fa4b3fd0ac51a684bceb5b9b6006a16c4',
     x86_64: 'c5f29c4e6e86c6f170e78eb8d321f091b19de638af14b427e80db08f05f0c56e'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
