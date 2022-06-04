require 'package'

class Py3_tomli_w < Package
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  @_ver = '1.0.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli-w.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-1_armv7l/py3_tomli_w-1.0.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-1_armv7l/py3_tomli_w-1.0.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-1_i686/py3_tomli_w-1.0.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-1_x86_64/py3_tomli_w-1.0.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '709fba1379da026c2b3e8af9d1ad6bd3ed5734f53ab13477435d873c6ef579a0',
     armv7l: '709fba1379da026c2b3e8af9d1ad6bd3ed5734f53ab13477435d873c6ef579a0',
       i686: 'b3b83ad54211417662308008f19f8851eaafd0b14b2978f139937f5f6894a8a0',
     x86_64: '26ab14b98ab7fc0742e864b84c54f176bebe1e78423856bf8cd7a3a5d9d832b7'
  })

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
