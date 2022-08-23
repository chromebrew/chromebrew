require 'package'

class Py3_cmarkgfm < Package
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version '2022.3.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/theacodes/cmarkgfm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.3.4_armv7l/py3_cmarkgfm-2022.3.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.3.4_armv7l/py3_cmarkgfm-2022.3.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.3.4_i686/py3_cmarkgfm-2022.3.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cmarkgfm/2022.3.4_x86_64/py3_cmarkgfm-2022.3.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bc0353b91ffb3dd020add427767e2f2f04a72f5a3c9af2aec69c55ac06a87a6a',
     armv7l: 'bc0353b91ffb3dd020add427767e2f2f04a72f5a3c9af2aec69c55ac06a87a6a',
       i686: '366c8bc7afebe3a50113b5423321f5b11a06a2fbc5ac8d0bd81142a350ce049f',
     x86_64: '71638e32662db8b194a5af22609b8bfd5fd6362841ef441b536d70435683ebc5'
  })

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_cffi'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
