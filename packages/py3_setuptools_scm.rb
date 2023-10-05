require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  @_ver = '8.0.4'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/8.0.4-py3.12_armv7l/py3_setuptools_scm-8.0.4-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/8.0.4-py3.12_armv7l/py3_setuptools_scm-8.0.4-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/8.0.4-py3.12_i686/py3_setuptools_scm-8.0.4-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/8.0.4-py3.12_x86_64/py3_setuptools_scm-8.0.4-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e358ef112f8266b6a3e325cedbbf219c0b71c97ec64cf5e425d8f9b17e4ff76',
     armv7l: '6e358ef112f8266b6a3e325cedbbf219c0b71c97ec64cf5e425d8f9b17e4ff76',
       i686: '6b1e3e3fbf59f49ec459fcafbdf4b217c2b9ab9cc2004a5d4c96b0c34f9fffcf',
     x86_64: '304d439d877f0d55c7e76fc29c0f5cf9c385b3f76f19e2503c4962051efbed20'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
end
