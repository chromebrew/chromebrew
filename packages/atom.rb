require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  @_ver = '1.58.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'

  source_url "https://github.com/atom/atom/releases/download/v#{@_ver}/atom-amd64.deb"
  source_sha256 '4310e1af8830952f4efe59349dfaacc39b0588f72449314bd795ed469421d2d5'

  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end
end
