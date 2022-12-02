require 'package'

class Py3_yamllint < Package
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  @_ver = '1.26.3'
  version "#{@_ver}-py3.11"
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3-py3.11_armv7l/py3_yamllint-1.26.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3-py3.11_armv7l/py3_yamllint-1.26.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3-py3.11_i686/py3_yamllint-1.26.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3-py3.11_x86_64/py3_yamllint-1.26.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '28bbff4485afa48cb71885d35f07fed58b51c05fa98d3882820fa52a4ab4dafa',
     armv7l: '28bbff4485afa48cb71885d35f07fed58b51c05fa98d3882820fa52a4ab4dafa',
       i686: '8eb2752adcc48b7c8b06a39427c7265534ece8368ac879959210c6db4e74c2f1',
     x86_64: '32c6d94fa374a1075ef243fa3eb76a0b14f28da5541f7729a74ab55b81fbea07'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
