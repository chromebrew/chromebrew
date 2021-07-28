require 'package'

class Py3_jinja2 < Package
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  @_ver = '2.11.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/jinja.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/2.11.3_armv7l/py3_jinja2-2.11.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/2.11.3_armv7l/py3_jinja2-2.11.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/2.11.3_i686/py3_jinja2-2.11.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/2.11.3_x86_64/py3_jinja2-2.11.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd3e75f478bca3d6a91b1482b055646af9cb49b5e2a52941b30b4378cc7ddd8a2',
     armv7l: 'd3e75f478bca3d6a91b1482b055646af9cb49b5e2a52941b30b4378cc7ddd8a2',
       i686: '4c6e6345689b30e015772cd0fff51be3ace97989dfb78aadcb0c4ac0b3005cd6',
     x86_64: '7f92ed068506f415c0e2c95d32131f65be19181013f0db99f6c031a55566b1e5'
  })

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
