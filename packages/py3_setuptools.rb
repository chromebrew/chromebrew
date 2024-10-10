require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cba57a97fad9270cb46ea14be7124f6efa4507e83da8098eb684d46cec8d0b0',
     armv7l: '6cba57a97fad9270cb46ea14be7124f6efa4507e83da8098eb684d46cec8d0b0',
       i686: '1a2e568f03ae1665a943f7f40bc22fd58c0fbed3f27e17c007ab8a33f8aaa801',
     x86_64: 'f7653efe47d0def2898a6366ae466bd1f06c411ba4c76a17246577d7925a8d8a'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    if Kernel.system('which zstd', %i[out err] => File::NULL)
      system 'python3 -m pip uninstall setuptools -y', exception: false
      system 'python3 -m pip install -I --force-reinstall --no-deps setuptools', exception: false
    end
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false if Kernel.system('which zstd', %i[out err] => File::NULL)
  end
end
