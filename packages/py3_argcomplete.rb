require 'package'

class Py3_argcomplete < Package
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  @_ver = '1.12.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kislyuk/argcomplete.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3_armv7l/py3_argcomplete-1.12.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3_armv7l/py3_argcomplete-1.12.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3_x86_64/py3_argcomplete-1.12.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1ff2f9b0a998bcb04c5b63e256f347a93cd5e8cc7930aaf3efb89d29b18bc438',
     armv7l: '1ff2f9b0a998bcb04c5b63e256f347a93cd5e8cc7930aaf3efb89d29b18bc438',
     x86_64: 'ad27365654a37640bff243e4c03b0ed06cb5a3cb5a0abcf14feb4b207643d110'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
