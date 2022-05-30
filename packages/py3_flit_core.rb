require 'package'

class Py3_flit_core < Package
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.7.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1_armv7l/py3_flit_core-3.7.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1_armv7l/py3_flit_core-3.7.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1_i686/py3_flit_core-3.7.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1_x86_64/py3_flit_core-3.7.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6cd60febd51da85301f56efe8dd2cecb1e9538d39a9b73051fae4e5bcf5ebd38',
     armv7l: '6cd60febd51da85301f56efe8dd2cecb1e9538d39a9b73051fae4e5bcf5ebd38',
       i686: 'd0e8c456b76858a20919059f5b9ea450215ed7eaffa9b240c71fc169b99e6b18',
     x86_64: '02cdf0552501cd995130a2f48d38329beda696c45b7cb20a9224128845d354cb'
  })

  def self.build
    Dir.chdir 'flit_core' do
      system "python3 -m build #{PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir 'flit_core' do
      system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
    end
  end
end
