require 'package'

class Py3_sphinxcontrib_devhelp < Package
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-devhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_i686/py3_sphinxcontrib_devhelp-1.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_x86_64/py3_sphinxcontrib_devhelp-1.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3196686ec01222742cb48ee585aa5060203f7238a0636f691dd70d19c4ea68c1',
     armv7l: '3196686ec01222742cb48ee585aa5060203f7238a0636f691dd70d19c4ea68c1',
       i686: 'dbbea0432ac6ce25922765f23d2e4ee98dfc3a89f7175c5353df32ff19dcd3be',
     x86_64: 'a325888dce188a29eb4a91c01819c16261e6c1f9cd88478ecf0b8e316a180462'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
