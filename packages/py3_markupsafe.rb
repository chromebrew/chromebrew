require 'package'

class Py3_markupsafe < Package
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '1.1.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/1.1.1_armv7l/py3_markupsafe-1.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/1.1.1_armv7l/py3_markupsafe-1.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/1.1.1_i686/py3_markupsafe-1.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/1.1.1_x86_64/py3_markupsafe-1.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '05269eb76a28496280e09830e855ceac625562826e0d31b8c72eef0d655a8a7a',
     armv7l: '05269eb76a28496280e09830e855ceac625562826e0d31b8c72eef0d655a8a7a',
       i686: 'a6d5aaf27943187471c6c312d067b9151482324104095bdf792b4702f4ea39f8',
     x86_64: 'c716a9294a7e21ec561e24aa85b10b20ba5c09234054b5a37f1d95d38b7d86be'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
