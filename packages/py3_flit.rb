require 'package'

class Py3_flit < Package
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.7.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1_armv7l/py3_flit-3.7.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1_armv7l/py3_flit-3.7.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1_i686/py3_flit-3.7.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1_x86_64/py3_flit-3.7.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0d3d6d84c6086b31bd4e1aadcb507c5492ab87e64dc866e1064343c6fa1e82ec',
     armv7l: '0d3d6d84c6086b31bd4e1aadcb507c5492ab87e64dc866e1064343c6fa1e82ec',
       i686: '33b26c11c228eea59b6723633f057171930731b3cc653f864eea093ebd79732f',
     x86_64: 'ca2b38b085a2bb35d5a42daa20209c15cf94b613eea6ecadd2f4c78afc1ee655'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
