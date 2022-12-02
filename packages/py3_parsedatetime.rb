require 'package'

class Py3_parsedatetime < Package
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-py3.11_armv7l/py3_parsedatetime-2.6-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-py3.11_armv7l/py3_parsedatetime-2.6-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-py3.11_i686/py3_parsedatetime-2.6-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-py3.11_x86_64/py3_parsedatetime-2.6-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '633fea31368b06f6aa13fdd5cd9f52159b3910dfc19a68f77d182a75e69c0007',
     armv7l: '633fea31368b06f6aa13fdd5cd9f52159b3910dfc19a68f77d182a75e69c0007',
       i686: 'e7467fd8bd1ae2a734aec2fa0851b628a99b04f886398a95d1a8c8726645ab23',
     x86_64: 'ea2d58b5bbd901016efb3c21f680c696d18779f8122dd4b216a1a1218a994598'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
