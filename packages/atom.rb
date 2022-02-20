require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  @_ver = '1.59.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'

  source_url "https://github.com/atom/atom/releases/download/v#{@_ver}/atom-amd64.deb"
  source_sha256 'f14423a80445f6e56ea7ac1cef788d0295617431cc4d428e3f5b247994a838b5'

  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end
end
