require 'package'

class Py3_chardet < Package
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  @_ver = '4.0.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/chardet/chardet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0_armv7l/py3_chardet-4.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0_armv7l/py3_chardet-4.0.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0_x86_64/py3_chardet-4.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1f5e8a5b489edf07d57eef7ece1f9192d9271c64c9be8046dc5cf4545a83c365',
     armv7l: '1f5e8a5b489edf07d57eef7ece1f9192d9271c64c9be8046dc5cf4545a83c365',
     x86_64: '68734f0138f0d5c9e052f594b9119c05d92058fc5297b5bda3f712aab94df215'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
