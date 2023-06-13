require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  version '1.60.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/atom/atom/releases/download/v#{version}/atom-amd64.deb"
  source_sha256 '5c7c0259062b9d4911d2537bfceaff5316f9de111698840a90d7cd497df891a6'

  no_compile_needed

  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv '*', CREW_DEST_PREFIX
  end
end
