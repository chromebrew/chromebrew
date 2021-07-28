require 'package'

class Py3_smartypants < Package
  description 'Smartypants translates plain ASCII punctuation characters into "smart" typographic punctuation HTML entities.'
  homepage 'https://github.com/leohemsted/smartypants.py/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/leohemsted/smartypants.py.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1_armv7l/py3_smartypants-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1_armv7l/py3_smartypants-2.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1_i686/py3_smartypants-2.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1_x86_64/py3_smartypants-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '93ec8b6d99d9d3c20fef9901de46375465f7b5211af30c4fcef4133cb93a73e2',
     armv7l: '93ec8b6d99d9d3c20fef9901de46375465f7b5211af30c4fcef4133cb93a73e2',
       i686: '1cdc95854b2c1245e784baad8262b1fbbe8ebc134df44f2d424e48bb04b00e1a',
     x86_64: '0bebd464e086c86be7dc31eb52a664959cc292b9e9e021970cf4daf396d9ca36'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
