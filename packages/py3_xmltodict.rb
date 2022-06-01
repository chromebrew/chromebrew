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
    aarch64: 'e6e260cb091e9b5e235e1d2d27334694b863dc58a5acf92c1dde94672e83462c',
     armv7l: 'e6e260cb091e9b5e235e1d2d27334694b863dc58a5acf92c1dde94672e83462c',
       i686: 'c788c22328fae7a225a17d7329f69dd8a3255ae0a179011b0d66fc291aecdc77',
     x86_64: '1b6f20ad9ccbdd7a3012f370c20d4664df2c5c2e107cb6ded6875e405ec2b7a1'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
