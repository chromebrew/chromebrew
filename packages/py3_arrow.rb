require 'package'

class Py3_arrow < Package
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  @_ver = '1.1.1'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/arrow-py/arrow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1-py3.11_armv7l/py3_arrow-1.1.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1-py3.11_armv7l/py3_arrow-1.1.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1-py3.11_i686/py3_arrow-1.1.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1-py3.11_x86_64/py3_arrow-1.1.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6770d9c201550328f9542b8dcc34a407716737220b74aaa8fb12afd1fbd2e319',
     armv7l: '6770d9c201550328f9542b8dcc34a407716737220b74aaa8fb12afd1fbd2e319',
       i686: '50afb9f2aaa11c60499595470777ab06df04fc923f4c8373f46117a366f19daf',
     x86_64: 'e3aff75ce3fa5d5734632693c11ebb8bd3766a58e20546b2187c879b6827cd83'
  })

  depends_on 'py3_dateutil'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
