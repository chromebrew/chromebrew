require 'package'

class Py3_decorator < Package
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  @_ver = '4.4.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/micheles/decorator.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_armv7l/py3_decorator-4.4.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_armv7l/py3_decorator-4.4.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_i686/py3_decorator-4.4.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_x86_64/py3_decorator-4.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b632c1aa8cc7685ba958b6fd5c4557d1ac2a0ce0d32e762a6f69abb7b0da6f2a',
     armv7l: 'b632c1aa8cc7685ba958b6fd5c4557d1ac2a0ce0d32e762a6f69abb7b0da6f2a',
       i686: 'e4e7da29c241262855d8562b2c3b1004987158679885475a87da74ca51ec79a9',
     x86_64: '4bb4f252873a800fa529e224e587a0cdc8ba0ed7ef678c7d73110f7b7c05bccf'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
