require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version '75.0.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5364226f0d01ded88a9e18c77495690f164afcc58e141ee6174a81fd762b19ca',
     armv7l: '5364226f0d01ded88a9e18c77495690f164afcc58e141ee6174a81fd762b19ca',
       i686: '5c1ba444f2dd02ec91f5452bb4cb3eb7f24598c23209c6b3e444577d50b85abc',
     x86_64: 'daba4062a35609f1a04e1da039b5851c3906f7e00523cf42b306fb61fff5b826'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    system 'python3 -m pip uninstall setuptools -y', exception: false
    system 'python3 -m pip install setuptools', exception: false
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false
  end
end
