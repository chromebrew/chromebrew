require 'package'

class Py3_future < Package
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  @_ver = '0.18.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-py3.11_armv7l/py3_future-0.18.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-py3.11_armv7l/py3_future-0.18.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-py3.11_i686/py3_future-0.18.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-py3.11_x86_64/py3_future-0.18.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2caee935538e26ba4174b967489d1eba8091582e5fee64a51c35639e77aa5642',
     armv7l: '2caee935538e26ba4174b967489d1eba8091582e5fee64a51c35639e77aa5642',
       i686: 'ccef9736211e07e52b9d401595357560431899376d015160343a1ab6a808c1e8',
     x86_64: '8b10496536bdda1e641b621937a5a2d1d796a2acae1ada65892a33905ad01df6'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
