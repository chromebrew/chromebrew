require 'package'

class Py3_argcomplete < Package
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  @_ver = '1.12.3'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kislyuk/argcomplete.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-1_armv7l/py3_argcomplete-1.12.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-1_armv7l/py3_argcomplete-1.12.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-1_i686/py3_argcomplete-1.12.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-1_x86_64/py3_argcomplete-1.12.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a3ac29ae936f90889eeb0040f35bb475db3689640d512171905756cb1491e022',
     armv7l: 'a3ac29ae936f90889eeb0040f35bb475db3689640d512171905756cb1491e022',
       i686: '504f03412cd08efa8c456f072c87fcb33830114b516ab735e38d3d558e1c8519',
     x86_64: 'a08ec552c6c6cf718f6a074ca96aa9f4d32794fe1fb74d2da91cc15243df929f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
