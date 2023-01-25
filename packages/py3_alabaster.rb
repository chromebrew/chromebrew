require 'package'

class Py3_alabaster < Package
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  @_ver = '0.7.12'
  version "#{@_ver}-py3.11"
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'https://github.com/bitprophet/alabaster.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-py3.11_armv7l/py3_alabaster-0.7.12-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-py3.11_armv7l/py3_alabaster-0.7.12-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-py3.11_i686/py3_alabaster-0.7.12-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-py3.11_x86_64/py3_alabaster-0.7.12-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1f7e4d77b30d6a8a99db2fa8f287ce2083f9a9319016a053c279a126da2242ff',
     armv7l: '1f7e4d77b30d6a8a99db2fa8f287ce2083f9a9319016a053c279a126da2242ff',
       i686: '6eeec008185ffaa8e146ce342009649149c069f3dea48e8beef07cfa691a3020',
     x86_64: 'd2a6ccf5010567c119639e8c16c625de222a06be0582d5378105f37e543300f2'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
