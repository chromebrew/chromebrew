require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "78.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a81eb2a48eac7c4a1913f34382ec4143032ba2866c444a5c2d0a0cc7d496bb6b',
     armv7l: 'a81eb2a48eac7c4a1913f34382ec4143032ba2866c444a5c2d0a0cc7d496bb6b',
       i686: 'efc3fbd5649f9d492eb48b82d18e4a47c06c2ee908c88e0303173625fe426efe',
     x86_64: '76c9099fd5d997e23e7091c872543142cbba8973d07efe5b0a01cae51a45d3dc'
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
