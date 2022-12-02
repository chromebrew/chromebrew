require 'package'

class Py3_abimap < Package
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  @_ver = '0.3.2'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ansasaki/abimap.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.11_armv7l/py3_abimap-0.3.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.11_armv7l/py3_abimap-0.3.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.11_i686/py3_abimap-0.3.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.11_x86_64/py3_abimap-0.3.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5a485255b305b0f48dca8e80950e36ebaa4937c5e5e3e47703367f050c67b748',
     armv7l: '5a485255b305b0f48dca8e80950e36ebaa4937c5e5e3e47703367f050c67b748',
       i686: '821245d0c9c4ef62d32aa84d10a928223853dfb56696c352b9393c1a63438efe',
     x86_64: 'a5588bdec847d4b46483068b6d060ad9763ed03fc6fef3ea8f1fda6cb70b3da8'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
