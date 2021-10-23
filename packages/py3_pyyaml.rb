require 'package'

class Py3_pyyaml < Package
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  @_ver = '6.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_armv7l/py3_pyyaml-6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_armv7l/py3_pyyaml-6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_i686/py3_pyyaml-6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_x86_64/py3_pyyaml-6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2e1bd6e6616e9d49aa4a14cd7713eb8221ca83d87c468abebb07cfe040553c50',
     armv7l: '2e1bd6e6616e9d49aa4a14cd7713eb8221ca83d87c468abebb07cfe040553c50',
       i686: '7c3045a78c53fcbf422569f19f25bb8cb6a7e548676f38b14412793ae337b4bb',
     x86_64: '7bf20f02d1f89faa3452ef15351a556a116a5e76d7e261a5cda4974dd0d113e9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
