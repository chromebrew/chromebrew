require 'package'

class Py3_fasteners < Package
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  @_ver = '0.16.3'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/harlowja/fasteners.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3-py3.11_armv7l/py3_fasteners-0.16.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3-py3.11_armv7l/py3_fasteners-0.16.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3-py3.11_i686/py3_fasteners-0.16.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3-py3.11_x86_64/py3_fasteners-0.16.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bfaebae20721511eb25f23ac6a5183255301329f7a289322ce3232d09866e1b3',
     armv7l: 'bfaebae20721511eb25f23ac6a5183255301329f7a289322ce3232d09866e1b3',
       i686: '70509e8681c3514e092b4d73eead023c4f241e93c4fe822819e7c8240a00e961',
     x86_64: '50ba7f1da3a50de220155bebed56b4cabd9aca198bcba3deefbfdfb3186dddf0'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
