require 'package'

class Py3_mock < Package
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  @_ver = '4.0.3'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/testing-cabal/mock.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3-py3.11_armv7l/py3_mock-4.0.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3-py3.11_armv7l/py3_mock-4.0.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3-py3.11_i686/py3_mock-4.0.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3-py3.11_x86_64/py3_mock-4.0.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'af0273a79a3f73973b9005acd5dddb956f3a3bb0d43545b3054b6e4c06df879d',
     armv7l: 'af0273a79a3f73973b9005acd5dddb956f3a3bb0d43545b3054b6e4c06df879d',
       i686: 'c9d56be03f1e1c14ef0510c1800869c7faac8bbc90c086a1041d245345b64b37',
     x86_64: '944fd6c35accba7f188a498463ed6738f063386149716db0304ae181c8d9b829'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
