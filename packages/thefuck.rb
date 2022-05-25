require 'package'

class Thefuck < Package
  description 'Thef*ck is a magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck/'
  version '3.31'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvbn/thefuck.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.31_armv7l/thefuck-3.31-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.31_armv7l/thefuck-3.31-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.31_i686/thefuck-3.31-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.31_x86_64/thefuck-3.31-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cdef429be5b7192bc2d6c01f11806b5e71e08b02862a81e1463cebb7c04f59a5',
     armv7l: 'cdef429be5b7192bc2d6c01f11806b5e71e08b02862a81e1463cebb7c04f59a5',
       i686: 'ff2af1b04e69b0d2b117ef94d1bf6da5de58aaafc687fbafea35c6888631d8ed',
     x86_64: 'f51e73b3c59d1052923d4b6dd72af0767c6ad0a9ba05911cf1954d3dcd02f436'
  })

  depends_on 'py3_six'
  depends_on 'py3_colorama'
  depends_on 'py3_psutil'
  depends_on 'py3_pyte'
  depends_on 'py3_decorator'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
