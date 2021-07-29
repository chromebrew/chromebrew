require 'package'

class Py3_leather < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  @_ver = '0.3.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.3_armv7l/py3_leather-0.3.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.3_armv7l/py3_leather-0.3.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.3_x86_64/py3_leather-0.3.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f14d873fa5aa5becc163ad401060dc794a71a421a39ca3bb387801bfbfe75fcc',
     armv7l: 'f14d873fa5aa5becc163ad401060dc794a71a421a39ca3bb387801bfbfe75fcc',
     x86_64: '848cc859d20f8b8184cb3fe512d703073608e84a021bb57527a9103e4a61cdb9'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
