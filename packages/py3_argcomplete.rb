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
    aarch64: 'dd1fcdad56a26605bffd091df8605f2af638b3c5e96ffa30231040fe55d36965',
     armv7l: 'dd1fcdad56a26605bffd091df8605f2af638b3c5e96ffa30231040fe55d36965',
       i686: '3e857e22e68e5916bcffa9d2ee311ea12889ffd64d9264d21ea52ad4b58dc2c7',
     x86_64: '58ab02de00c117dd3bb4b06e9329151b16079d69f24fcb6ef0ec86ca65ee5d42'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
