require 'package'

class Py3_parsedatetime < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6_armv7l/py3_parsedatetime-2.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6_armv7l/py3_parsedatetime-2.6-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6_x86_64/py3_parsedatetime-2.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bb4a5c7932ccdaba5b29e981f1872fd84f22cf1dbbe36c210f20f30ca2e7461c',
     armv7l: 'bb4a5c7932ccdaba5b29e981f1872fd84f22cf1dbbe36c210f20f30ca2e7461c',
     x86_64: 'ad032dca3e09c204521a36b4f5e266c74c2add26b77fc034e6ee2782d278ec61'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
