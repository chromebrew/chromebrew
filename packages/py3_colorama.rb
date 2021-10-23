require 'package'

class Py3_colorama < Package
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  @_ver = '0.4.4'
  version "#{@_ver}-1"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/tartley/colorama.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_armv7l/py3_colorama-0.4.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_armv7l/py3_colorama-0.4.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_i686/py3_colorama-0.4.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_x86_64/py3_colorama-0.4.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8d78c0f6d926ccd3a968789ca44128fb528fd065014452d14e95cfef819a80c4',
     armv7l: '8d78c0f6d926ccd3a968789ca44128fb528fd065014452d14e95cfef819a80c4',
       i686: '08f10c3f40ab9b6bc5b49a8c01076b224a2c73969fd3ef6aeedd1fb484b14abf',
     x86_64: '503cc767d2f00882ed6f97e50970ae03c63c9ef6d9c8f0c8f2f59d12993a64c7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
