require 'package'

class Py3_sphinxcontrib_qthelp < Package
  description 'sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.3'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-qthelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-py3.11_armv7l/py3_sphinxcontrib_qthelp-1.0.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-py3.11_armv7l/py3_sphinxcontrib_qthelp-1.0.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-py3.11_i686/py3_sphinxcontrib_qthelp-1.0.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-py3.11_x86_64/py3_sphinxcontrib_qthelp-1.0.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6cf2950feea47c140a37a1f3ff64ce04284c5b9c2a835d6340abcb39984448cc',
     armv7l: '6cf2950feea47c140a37a1f3ff64ce04284c5b9c2a835d6340abcb39984448cc',
       i686: '7cee8a656532854372b73e92bf5aa9cbab84364767a8418e63f9456bf299c437',
     x86_64: 'eaddf48b547fb6882e7013dbd3bc1ecee0d449ea3e3f5103c61562866e4cc45f'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
