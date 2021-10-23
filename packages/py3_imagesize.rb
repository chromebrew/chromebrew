require 'package'

class Py3_imagesize < Package
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  @_ver = '1.1.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shibukawa/imagesize_py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_armv7l/py3_imagesize-1.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_armv7l/py3_imagesize-1.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_i686/py3_imagesize-1.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_x86_64/py3_imagesize-1.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6d171ff5e87c64a72175253b1d5178a996bda4fe63555a8ddeee6683b70dd531',
     armv7l: '6d171ff5e87c64a72175253b1d5178a996bda4fe63555a8ddeee6683b70dd531',
       i686: 'b98a80e7bec326f5ba3795143b6ad506b741136b413575137d19cafea7486cca',
     x86_64: '9b80b09d55b987647a118f15546ab30664b015bf1de9f901f8aeb77ac5b6f701'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
