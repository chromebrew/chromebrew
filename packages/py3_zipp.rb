require 'package'

class Py3_zipp < Package
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  @_ver = '3.5.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/zipp.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.5.0_armv7l/py3_zipp-3.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.5.0_armv7l/py3_zipp-3.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.5.0_i686/py3_zipp-3.5.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.5.0_x86_64/py3_zipp-3.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fcb28de86bc4709d0820bcf6b4ee7e4142198316b1b408d43ce6b96651d61fac',
     armv7l: 'fcb28de86bc4709d0820bcf6b4ee7e4142198316b1b408d43ce6b96651d61fac',
       i686: 'e24a64ca2e0131d63b5cf708ba9938ae0200b1fa93e84741a43990e173a9284d',
     x86_64: '120cc840acb223b7ca42f0946f1442d02fbfce8fead7537b8a614f68ba69adba'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
