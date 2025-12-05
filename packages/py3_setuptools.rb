require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9244496f10c86cd9ae6b3cda9d2a388fbc740733326bcd39ec2ae459aa9f5b5f',
     armv7l: '9244496f10c86cd9ae6b3cda9d2a388fbc740733326bcd39ec2ae459aa9f5b5f',
       i686: '92da77356bb2438d7c995396b9b5d9feb01d64723cc1e9c1f1b1071db6cf1663',
     x86_64: '284250e9ff28390f1772ecfa3b64456e0d5fc5c35fb822ab568190a169ec6940'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok
  no_source_build

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
