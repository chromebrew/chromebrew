require 'package'

class Py3_xmltodict < Package
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  @_ver = '0.12.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martinblech/xmltodict.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-1_armv7l/py3_xmltodict-0.12.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-1_armv7l/py3_xmltodict-0.12.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-1_i686/py3_xmltodict-0.12.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0-1_x86_64/py3_xmltodict-0.12.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '846d1b13e1ddd37f7e025f4ef03ac8b20749c82ea6c64ddf17ffc78495827ddc',
     armv7l: '846d1b13e1ddd37f7e025f4ef03ac8b20749c82ea6c64ddf17ffc78495827ddc',
       i686: '7e74f9f06d04b40c600f9a0477a41238f6355420d82680a5759f4df0ab70494b',
     x86_64: '5a91d570d8d1bb26604dc37ef60558212f2ffec9b108553e59d0b92378e248b2'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
