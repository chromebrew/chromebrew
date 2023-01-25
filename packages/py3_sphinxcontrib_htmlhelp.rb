require 'package'

class Py3_sphinxcontrib_htmlhelp < Package
  description 'sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '2.0.0'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-htmlhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0-py3.11_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0-py3.11_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0-py3.11_i686/py3_sphinxcontrib_htmlhelp-2.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0-py3.11_x86_64/py3_sphinxcontrib_htmlhelp-2.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e64209d3f7b193342c12783ca8678c889fb818c6f2ecd19364023f3e87948c3a',
     armv7l: 'e64209d3f7b193342c12783ca8678c889fb818c6f2ecd19364023f3e87948c3a',
       i686: '60314518b427fa43042fa5502cf21aa9436d16aac7ece043adfdf82d75fdb9d1',
     x86_64: 'aed1995251e2d87c173b05efcab4631736fd94edb920b215dd1e13aed14fb134'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
