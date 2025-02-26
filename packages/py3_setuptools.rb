require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.8.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c20645bac81a6b08eb6ff590490a9f10b8fa5cd2978dc5d64f56ac9e96285901',
     armv7l: 'c20645bac81a6b08eb6ff590490a9f10b8fa5cd2978dc5d64f56ac9e96285901',
       i686: '8523ba2b22c0eaef1875fe01e6f4b072dcedf5d7517f8cc66bbc0311aa6abb61',
     x86_64: 'c25728b0f5954865f915dab26157bbcdb113f9ec59b1b66a93b6113144b093c6'
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
