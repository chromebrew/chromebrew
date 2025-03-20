require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "77.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94bb0702d63bc168528494b7c62458cd7224d2f7ea1dcca9c73553463a2cdb75',
     armv7l: '94bb0702d63bc168528494b7c62458cd7224d2f7ea1dcca9c73553463a2cdb75',
       i686: '0cf89178d73b4158211461a5ce25b71331fefc2ac0eb620925a15a4918ba8498',
     x86_64: '4887386853777d6d96034934065479458cc9c24a74be417727638ac452653a53'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    if File.which('zstd')
      system 'python3 -m pip uninstall setuptools -y', exception: false
      system 'python3 -m pip install -I --force-reinstall --no-deps setuptools', exception: false
    end
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false if Kernel.system('which zstd', %i[out err] => File::NULL)
  end
end
