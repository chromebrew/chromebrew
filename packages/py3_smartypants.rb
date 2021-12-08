require 'package'

class Py3_smartypants < Package
  description 'Smartypants translates plain ASCII punctuation characters into "smart" typographic punctuation HTML entities.'
  homepage 'https://github.com/leohemsted/smartypants.py/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/leohemsted/smartypants.py.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-1_armv7l/py3_smartypants-2.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-1_armv7l/py3_smartypants-2.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-1_i686/py3_smartypants-2.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-1_x86_64/py3_smartypants-2.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '09efcfdcfade8a76e0b62a9dbd3b6966ed76e2a81f029f63f4c8cd9465e59178',
     armv7l: '09efcfdcfade8a76e0b62a9dbd3b6966ed76e2a81f029f63f4c8cd9465e59178',
       i686: 'd4e5871f064d5326fedc15f3fca103e921eb65c022d320515eb8252c599ae18a',
     x86_64: '1b49fe2860b38492a3c6d473137147263c930554ef54c855de9cc9d07d03b30a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
