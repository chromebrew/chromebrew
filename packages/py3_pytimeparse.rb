require 'package'

class Py3_pytimeparse < Package
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  @_ver = '1.1.8'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.11_armv7l/py3_pytimeparse-1.1.8-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.11_armv7l/py3_pytimeparse-1.1.8-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.11_i686/py3_pytimeparse-1.1.8-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.11_x86_64/py3_pytimeparse-1.1.8-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5da8a2859d33f4b1442bb26d66bdddaab6c46ee86983cd59411d966f29211e65',
     armv7l: '5da8a2859d33f4b1442bb26d66bdddaab6c46ee86983cd59411d966f29211e65',
       i686: '333fd358cd27ba8ab00983e4a6dd23835d5f28d43907223e7c22e2c81381612e',
     x86_64: 'b93618489600390b6c9ef56ef72543803df440d87ed391e10e14a79d0e70293a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
