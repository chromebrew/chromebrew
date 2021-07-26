require 'package'

class Thefuck < Package
  description 'Thef*ck is a magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck/'
  @_ver = '3.30'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvbn/thefuck.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.30_armv7l/thefuck-3.30-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.30_armv7l/thefuck-3.30-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.30_i686/thefuck-3.30-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thefuck/3.30_x86_64/thefuck-3.30-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '69d4a4d1eafae79a1cac4e9f94b753f068bbf5cebc8a36ec5a8cea1d20b1eac2',
     armv7l: '69d4a4d1eafae79a1cac4e9f94b753f068bbf5cebc8a36ec5a8cea1d20b1eac2',
       i686: 'cd65fb828c278084da5723cfadce71ee345ca01f087fb0faa1e2637c1d0329ce',
     x86_64: '80140c5fdbc5a5aa1629bb8b8272c0ef4e006e270e1eaf843530a7bdad9cb337'
  })

  depends_on 'py3_six'
  depends_on 'py3_colorama'
  depends_on 'py3_psutil'
  depends_on 'py3_pyte'
  depends_on 'py3_decorator'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
