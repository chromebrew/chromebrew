require 'package'

class Py3_flit_core < Package
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.9.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.9.0-py3.12_armv7l/py3_flit_core-3.9.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.9.0-py3.12_armv7l/py3_flit_core-3.9.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.9.0-py3.12_i686/py3_flit_core-3.9.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.9.0-py3.12_x86_64/py3_flit_core-3.9.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '68402651f832c896ff80e5b44435a60dc9123f89bf36a1656bc572f42731c817',
     armv7l: '68402651f832c896ff80e5b44435a60dc9123f89bf36a1656bc572f42731c817',
       i686: '01a2f8a973d3d1a298221235bd99043d05980de1d79bacf8a03173fe0ef653b3',
     x86_64: 'd870b86028d67c97728d91a490a93e473db11121f6f39c42890a3db8d0cc7407'
  })

  depends_on 'python3'

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
