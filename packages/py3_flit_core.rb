require 'package'

class Py3_flit_core < Package
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.7.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1-1_i686/py3_flit_core-3.7.1-1-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.7.1-1_x86_64/py3_flit_core-3.7.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '8f8f77092250172966e361e3471962836bb7d8dc00d8f2bcd4257c890309ca44',
  x86_64: 'e20eb9cd5a7dec671b74c6f2096544aa311a2340fbf34c5b86879441816da233'
  })

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
