require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '0.12.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pep517.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_armv7l/py3_pep517-0.12.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_armv7l/py3_pep517-0.12.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_i686/py3_pep517-0.12.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_x86_64/py3_pep517-0.12.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fabe3ecf70eed72c0df14ca2251baab7abacaeb2f120ab33d2837ba9bf472519',
     armv7l: 'fabe3ecf70eed72c0df14ca2251baab7abacaeb2f120ab33d2837ba9bf472519',
       i686: '62fe92d192ce43d0da02458c24a0f22bc2d477e1d16fe05f58edd8d6b7af83b0',
     x86_64: '3e49aa5bef6b9ed8c404421d10b6dc5c1380b5eb89f4dbb7c6ee6be2309204f3'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
