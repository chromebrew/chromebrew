require 'package'

class Py3_pyicu < Package
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  @_ver = '2.7.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.pyicu.org/main/pyicu.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4-py3.11_armv7l/py3_pyicu-2.7.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4-py3.11_armv7l/py3_pyicu-2.7.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4-py3.11_i686/py3_pyicu-2.7.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyicu/2.7.4-py3.11_x86_64/py3_pyicu-2.7.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '083890c5449a49253080d5d229df05a9a2fee92b18d631be62b4d994c52e5584',
     armv7l: '083890c5449a49253080d5d229df05a9a2fee92b18d631be62b4d994c52e5584',
       i686: '0678ca2c498d4d0f1b6adaf71f82f3e79ac5edb0455a37405add42e4c1a1d318',
     x86_64: 'c72cbc39569332967082b3d1e934aeb1823e494eadf8ea172d401e74b6a439c5'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
