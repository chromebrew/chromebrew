require 'package'

class Py3_idna < Package
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  @_ver = '3.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.1_armv7l/py3_idna-3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.1_armv7l/py3_idna-3.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.1_x86_64/py3_idna-3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8b1d43393a55416ce6d245b757c8fb471e6e9a05b0e0b97c03bdfeae61daf527',
     armv7l: '8b1d43393a55416ce6d245b757c8fb471e6e9a05b0e0b97c03bdfeae61daf527',
     x86_64: '81ae966d16b99111df47c49bad147ab4517a91dc1056ef3f7037edc0c1ac3767'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
