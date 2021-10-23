require 'package'

class Py3_markupsafe < Package
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_i686/py3_markupsafe-2.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_x86_64/py3_markupsafe-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a3dbfc766a5de540948b8626e1530f7c3b239d3cd674d58a8781032343d309be',
     armv7l: 'a3dbfc766a5de540948b8626e1530f7c3b239d3cd674d58a8781032343d309be',
       i686: 'b996fefd01e75933baa5fe6c8dbf5d0dbe82a223c68f8ea002856ea551ccaf52',
     x86_64: '979b8c51b25a847618e773da0d1bab55dcc3b1abcd8384a5812fe0d935e7b488'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
