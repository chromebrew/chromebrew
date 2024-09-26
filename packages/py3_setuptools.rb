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
    aarch64: 'd406b7a56fc8489151bd5a762115b2e7778329c8a6817f5c7c7a1156008dc945',
     armv7l: 'd406b7a56fc8489151bd5a762115b2e7778329c8a6817f5c7c7a1156008dc945',
       i686: 'e930f0d27a25bd3706e303efa235ca42346baf7c091880bfec8b379972a862fb',
     x86_64: '741a36a2db9cb6de9a1f7fa841f63f46b3d6bc589069337f28984b69d72b4371'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    system 'python3 -m pip uninstall setuptools -y', exception: false
    system 'python3 -m pip install -I --force-reinstall --no-deps setuptools', exception: false
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false
  end
end
