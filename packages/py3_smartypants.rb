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
    aarch64: 'd91f17e4f13ebad85516130ee75003cc27c138babe8fcd2d3a59a607eb69f5f3',
     armv7l: 'd91f17e4f13ebad85516130ee75003cc27c138babe8fcd2d3a59a607eb69f5f3',
       i686: 'effac355e2e0464e9ed36a0bceace3e1c74b3e8ff472436ffa580e8dab949127',
     x86_64: 'e0150891604a5b890a18ca1701d01ecad4248d908d5b3df91052b67c275fb95d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
