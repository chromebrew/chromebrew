require 'package'

class Py3_imagesize < Package
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  @_ver = '1.1.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shibukawa/imagesize_py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-py3.11_armv7l/py3_imagesize-1.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-py3.11_armv7l/py3_imagesize-1.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-py3.11_i686/py3_imagesize-1.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-py3.11_x86_64/py3_imagesize-1.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80fd146e253a665a9be0c0c8c0dad52a1c1389ed514382a13092d8daba2afef1',
     armv7l: '80fd146e253a665a9be0c0c8c0dad52a1c1389ed514382a13092d8daba2afef1',
       i686: 'e110396660dfe89b969d6632b4c4adf447c6eacf842f82a1ad6ea8453fba0d43',
     x86_64: '01fa549a37079b466e6b740f9b0764d00ac0cda284182fc98f6d968f7f9419f1'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
