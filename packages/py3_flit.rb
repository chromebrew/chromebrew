require 'package'

class Py3_flit < Package
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.7.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-py3.11_armv7l/py3_flit-3.7.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-py3.11_armv7l/py3_flit-3.7.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-py3.11_i686/py3_flit-3.7.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-py3.11_x86_64/py3_flit-3.7.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e42adb538b73ca79c0edbe15c136594901ba8603b19b4a563c7e3166c92a51e',
     armv7l: '6e42adb538b73ca79c0edbe15c136594901ba8603b19b4a563c7e3166c92a51e',
       i686: '4f12e828705743f113f4e0a3014d51f1396810d2fe743f36687bf4bd1e90bef7',
     x86_64: 'ef549b3f9aaba5b26bb60ce47aa8f4b869558f4646d1d93f9b6476172beda7b0'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
