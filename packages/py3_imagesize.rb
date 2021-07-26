require 'package'

class Py3_imagesize < Package
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  @_ver = '1.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shibukawa/imagesize_py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0_armv7l/py3_imagesize-1.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0_armv7l/py3_imagesize-1.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0_x86_64/py3_imagesize-1.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8a50d8638aa483659890a2f8a7fbb728ba06f144ee744d8ce58f5e0fa4673969',
     armv7l: '8a50d8638aa483659890a2f8a7fbb728ba06f144ee744d8ce58f5e0fa4673969',
     x86_64: '43f5e898252eefbf95f4f8671ea60bd7936ba21dbf26d1f1ff5520a29f8f3c49'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
