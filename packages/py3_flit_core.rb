require 'package'

class Py3_flit_core < Package
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.8.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_armv7l/py3_flit_core-3.8.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_armv7l/py3_flit_core-3.8.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_i686/py3_flit_core-3.8.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_x86_64/py3_flit_core-3.8.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '85ea9d73f58cb78eb263a47bed9c0c45d4b1a2e454fc2f50472d080d817ad8d8',
     armv7l: '85ea9d73f58cb78eb263a47bed9c0c45d4b1a2e454fc2f50472d080d817ad8d8',
       i686: 'c92eff1ea8ac7df10faae1cbe95039660cdbfea2805ae6bd1d7644cba2df700e',
     x86_64: '3152ec858076c6beb0bea4427ce1a7041045787c58ff72fe83b31ee18496c6e1'
  })

  depends_on 'python3'

  conflicts_ok

  def self.build
    Dir.chdir 'flit_core' do
      system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir 'flit_core' do
      system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
