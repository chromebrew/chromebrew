require 'package'

class Py3_typogrify < Package
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mintchaos/typogrify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7-py3.11_armv7l/py3_typogrify-2.0.7-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7-py3.11_armv7l/py3_typogrify-2.0.7-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7-py3.11_i686/py3_typogrify-2.0.7-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7-py3.11_x86_64/py3_typogrify-2.0.7-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '42f76b782953bf9c6b4a771fbca1631ca54ff9f3a0692fcdd43d2a6eae805b85',
     armv7l: '42f76b782953bf9c6b4a771fbca1631ca54ff9f3a0692fcdd43d2a6eae805b85',
       i686: '8d32e6be4f3621c806d2fb65185c056030769ff6b2fc9ea90636126e3bef02ae',
     x86_64: '50415d47bcac9f8fc8099ccfd190cac2c17fe16c40d21afc6ba105463d129e37'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
