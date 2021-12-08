require 'package'

class Py3_typogrify < Package
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '2.0.7'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mintchaos/typogrify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_i686/py3_typogrify-2.0.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_x86_64/py3_typogrify-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '13737d5f686a40036af5ef16fc69765afe40b3d7035c92cd45685889b5b58ed6',
     armv7l: '13737d5f686a40036af5ef16fc69765afe40b3d7035c92cd45685889b5b58ed6',
       i686: '5b35cafb95bcc54edca7424f5f997349eb93255b37e2b7acdf19056a8fbbafd1',
     x86_64: '6e2b05123214d735e3440a8c6927af84fe16eefc8d19bc76585e6bc549add623'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
