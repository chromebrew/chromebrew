require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '0.12.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pep517.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-1_armv7l/py3_pep517-0.12.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-1_armv7l/py3_pep517-0.12.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-1_i686/py3_pep517-0.12.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-1_x86_64/py3_pep517-0.12.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '531d486672d57f800f4e25810c86c82303adc8bfbc473a1bfc8256e055c5ca69',
     armv7l: '531d486672d57f800f4e25810c86c82303adc8bfbc473a1bfc8256e055c5ca69',
       i686: '1ec47c6bbb612d920218dcdf0d9504599ddaeb7aafe8502c3662daed1dab1213',
     x86_64: '55858ecb0039e660eefc6765b46a9c3c5a0ca835485b5a168d648c5718736362'
  })

  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
