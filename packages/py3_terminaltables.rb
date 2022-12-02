# NOTE: Archived upstream

require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-py3.11_armv7l/py3_terminaltables-3.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-py3.11_armv7l/py3_terminaltables-3.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-py3.11_i686/py3_terminaltables-3.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-py3.11_x86_64/py3_terminaltables-3.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fc78cb8009444853c05afa35ccf62190b3b6a7f5b18f77fc1e4f9d93368c687c',
     armv7l: 'fc78cb8009444853c05afa35ccf62190b3b6a7f5b18f77fc1e4f9d93368c687c',
       i686: '464d38f52fc0524e2467b948ddca803a72c92e730d48ad46beb776135e5ab689',
     x86_64: '8f7de7db4a81ee8ea7416ece300953153b80178a72ccb52a55e3076b8436504f'
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
