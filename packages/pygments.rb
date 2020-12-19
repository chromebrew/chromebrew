require 'package'

class Pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version '2.7.3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/29/60/8ff9dcb5eac7f4da327ba9ecb74e1ad783b2d32423c06ef599e48c79b1e1/Pygments-2.7.3.tar.gz'
  source_sha256 'ccf3acacf3782cbed4a989426012f1c535c9a90d3a7fc3f16d231b9372d2b716'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a0c567de5b740fa9156211359821ff1fa737c9a789f7d609e5d03a0a4d3d3eef',
     armv7l: 'a0c567de5b740fa9156211359821ff1fa737c9a789f7d609e5d03a0a4d3d3eef',
       i686: 'c80eefe6b9224f9bf83725b67fb435ff9f2c11f3a76d39b08f23ee4be2bfc082',
     x86_64: '726b9bf55accde82012775ec6aa1117a022d9f03cd8e6d12bb8bceaa8f4d9694',
  })

  def self.install
    system "pip3 install pygments --no-warn-script-location --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
