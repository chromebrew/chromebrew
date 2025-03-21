require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "77.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdbe97390891a80ec9fbb334ef9f69b9e805627bb68eae1fd3e5777f2f3bd4b1',
     armv7l: 'bdbe97390891a80ec9fbb334ef9f69b9e805627bb68eae1fd3e5777f2f3bd4b1',
       i686: '5d02917df2f0d85a2babe2e0d93baf20ab3265e59dbdf20dfa61140a32f45f9c',
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
