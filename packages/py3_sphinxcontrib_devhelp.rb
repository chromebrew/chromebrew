require 'package'

class Py3_sphinxcontrib_devhelp < Package
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2-883c'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-devhelp.git'
  git_hashtag '883cdd991b38dec85edafdeb61cb6af4064ca8f6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c_armv7l/py3_sphinxcontrib_devhelp-1.0.2-883c-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c_armv7l/py3_sphinxcontrib_devhelp-1.0.2-883c-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c_i686/py3_sphinxcontrib_devhelp-1.0.2-883c-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c_x86_64/py3_sphinxcontrib_devhelp-1.0.2-883c-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '867ea82ffb3ca7f1d7bdf1d6652944dc5c93125cc840711b5405fe8b1c4e5890',
     armv7l: '867ea82ffb3ca7f1d7bdf1d6652944dc5c93125cc840711b5405fe8b1c4e5890',
       i686: '3899039b6b44039f754c4f6c883cccb9f9bd74f4a86ff8ae00d9640024b5986a',
     x86_64: '1bfbedf5d7bdb170b7215c6815b96586db50c1c32b5506fd17409b527ce595ef'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
