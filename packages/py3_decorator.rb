require 'package'

class Py3_decorator < Package
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  @_ver = '4.4.2'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/micheles/decorator.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2-py3.11_armv7l/py3_decorator-4.4.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2-py3.11_armv7l/py3_decorator-4.4.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2-py3.11_i686/py3_decorator-4.4.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2-py3.11_x86_64/py3_decorator-4.4.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9074ac751a0d88ea23164e5611dd8921c7bfa37a12df0cf64d769d73787bd8db',
     armv7l: '9074ac751a0d88ea23164e5611dd8921c7bfa37a12df0cf64d769d73787bd8db',
       i686: 'd93a91e21d098779dad3b0667845bb6000171014130453965ebd4616dddb45c8',
     x86_64: '085e0a502866ce816c43932f6fc4635de47f52b4a7c1629f4fcc572a6159f0f9'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
