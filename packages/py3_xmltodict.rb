require 'package'

class Py3_xmltodict < Package
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  @_ver = '0.12.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martinblech/xmltodict.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-py3.11_armv7l/py3_xmltodict-0.12.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-py3.11_armv7l/py3_xmltodict-0.12.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-py3.11_i686/py3_xmltodict-0.12.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-py3.11_x86_64/py3_xmltodict-0.12.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8934e51e0d179b04f1af8f02a0d2258542d84183b6f2db4d0efee0e502a00fcf',
     armv7l: '8934e51e0d179b04f1af8f02a0d2258542d84183b6f2db4d0efee0e502a00fcf',
       i686: '11867e4b550ba2dedcc1fdb4efee473a2923807b71447dd298af341189a234af',
     x86_64: '4ce3e0327518c75e04e8204317674ca49e355ce679a06bc01f0c4ed14edd02b5'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
