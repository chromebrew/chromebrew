require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "78.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c67feb33eadd4f4a8eb0bbd6c03d2a3a67a0924de923282d7f0c3703e1a2e01',
     armv7l: '6c67feb33eadd4f4a8eb0bbd6c03d2a3a67a0924de923282d7f0c3703e1a2e01',
       i686: '5d02917df2f0d85a2babe2e0d93baf20ab3265e59dbdf20dfa61140a32f45f9c',
     x86_64: '30f561e65b1e82cac11d7ffb2a26e5e31772cd8f9082c1343e207baa8be7c2d1'
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
