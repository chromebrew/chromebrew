require 'package'

class Py3_zipp < Package
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  @_ver = '3.6.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/zipp.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_armv7l/py3_zipp-3.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_armv7l/py3_zipp-3.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_i686/py3_zipp-3.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0_x86_64/py3_zipp-3.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c13351985efd510376d3c0dd006db2a9a9a864d8a53bb5b4ad7a2e28a7f371b0',
     armv7l: 'c13351985efd510376d3c0dd006db2a9a9a864d8a53bb5b4ad7a2e28a7f371b0',
       i686: '243aaf716e43eaab87c43d47c77162b86f6b4b2a208c5da0aa62c0f1a2e43362',
     x86_64: 'cfc482639fe8a6af4b35c19f21c39836eb25638dcdf858686751783f7e51254b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
