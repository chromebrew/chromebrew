require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.7.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb903733e766fb07573464dd52e93b752b1b933ad0f6b7918878deb883d573aa',
     armv7l: 'fb903733e766fb07573464dd52e93b752b1b933ad0f6b7918878deb883d573aa',
       i686: 'f1b68a0b9945059b4d10aa7a8def0aa3510b1415ae031cdd92438df3bf6f1b8a',
     x86_64: '8110800df3441f029a2045931bd113b0a82fccb9581aa7f0ef579e27d9b1953e'
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
