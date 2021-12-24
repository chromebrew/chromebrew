require 'package'

class Py3_abimap < Package
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  @_ver = '0.3.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ansasaki/abimap.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_armv7l/py3_abimap-0.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_armv7l/py3_abimap-0.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_i686/py3_abimap-0.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_x86_64/py3_abimap-0.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '510be9f9f4186ae280597a5f194eb614e03c0688b52b4f3224e2c9bf25875d41',
     armv7l: '510be9f9f4186ae280597a5f194eb614e03c0688b52b4f3224e2c9bf25875d41',
       i686: 'f7c0665a23ffe01312d97693f5ee1cfef339935454479b47d352232f0cf79dcf',
     x86_64: 'e6e15242323246841df9b402f503208726bd64c2571f39b97443dc4fc3047259'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
