require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.rtfd.org/'
  @_ver = '1.0.6'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/csvkit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/csvkit/1.0.6_armv7l/csvkit-1.0.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/csvkit/1.0.6_armv7l/csvkit-1.0.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/csvkit/1.0.6_i686/csvkit-1.0.6-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/csvkit/1.0.6_x86_64/csvkit-1.0.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3caee2c61cee798fcf16d96ba310f0f77a8b237e56889f1cfe2d12a127f34961',
     armv7l: '3caee2c61cee798fcf16d96ba310f0f77a8b237e56889f1cfe2d12a127f34961',
       i686: 'cfefda5b4ef28946e6bfe0aad8ad5f2373bd14d3b273b5aa97dc40cbbaa3ebf3',
     x86_64: '0b12a20e97969ebb2e7cca57040824c772b2bcdcb824ab5f32618f1a79fed62d'
  })

  depends_on 'py3_six'
  depends_on 'py3_agate_dfb'
  depends_on 'py3_agate'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
