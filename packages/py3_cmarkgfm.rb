require 'package'

class Py3_cmarkgfm < Package
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  @_ver = '2022.10.27'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/theacodes/cmarkgfm.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.10.27-py3.11_armv7l/py3_cmarkgfm-2022.10.27-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.10.27-py3.11_armv7l/py3_cmarkgfm-2022.10.27-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.10.27-py3.11_i686/py3_cmarkgfm-2022.10.27-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.10.27-py3.11_x86_64/py3_cmarkgfm-2022.10.27-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '532500c5efe07254a760c187e60fd96fab2403de450cc52c1e7baa2e08486e12',
     armv7l: '532500c5efe07254a760c187e60fd96fab2403de450cc52c1e7baa2e08486e12',
       i686: 'cd6a02054a304a1cf3a35fef6242ba9e3c94bb0cc47b6f5aa7aa35a3489f9b27',
     x86_64: '4849972d806eb83d7fee77d9dd202f2859e373fd17852b4195ced7045292e0f9'
  })

  depends_on 'python3' => :build
  depends_on 'py3_cffi'
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
