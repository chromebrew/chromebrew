require 'package'

class Py3_tomli < Package
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  @_ver = '2.0.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1_armv7l/py3_tomli-2.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1_armv7l/py3_tomli-2.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1_i686/py3_tomli-2.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1_x86_64/py3_tomli-2.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de41b0810b3aebabd707fbabab530c47baaf08322a11966981a3db1ac2944fc8',
     armv7l: 'de41b0810b3aebabd707fbabab530c47baaf08322a11966981a3db1ac2944fc8',
       i686: '0309b9967791f8d04b021437270b4232d2f8365e7668e88b57b144a012a77be2',
     x86_64: 'edafb58e7d166f341ae3c0d47871b4804c8503cd72069a344584ed7fee7b226f'
  })

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
