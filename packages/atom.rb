require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  @_ver = '1.55.0'
  version @_ver
  compatibility 'x86_64'

  source_url "https://github.com/atom/atom/releases/download/v#{@_ver}/atom-amd64.deb"
  source_sha256 'e1c650fcfdfc09aafef0ecfe041d254ad9007fb3ca797dafd21c8333fd0b1340'

  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end
end
