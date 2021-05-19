require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  @_ver = '1.56.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64'

  source_url "https://github.com/atom/atom/releases/download/v#{@_ver}/atom-amd64.deb"
  source_sha256 '2010c8a782bbc1aa330a9b89135204bfb056d2e3a3c98d12b0fb5f4aae4d6ee7'

  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end
end
