require 'package'

class Py3_semantic_version < Package
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  @_ver = '2.10.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/rbarrois/python-semanticversion.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0_armv7l/py3_semantic_version-2.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0_armv7l/py3_semantic_version-2.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0_i686/py3_semantic_version-2.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0_x86_64/py3_semantic_version-2.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b832de0a522ff4a2557450581d6ade52a291cad326a3076b52fb45b86242e22c',
     armv7l: 'b832de0a522ff4a2557450581d6ade52a291cad326a3076b52fb45b86242e22c',
       i686: '48a21764f095779fb1bf8b2297692c5a5c8fa46b122d7b6d505c2a84fdf9a225',
     x86_64: 'fa6acafffe5bde9d5144dad90f5bf1e3570f6a578098422481b223c8f3a79679'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
