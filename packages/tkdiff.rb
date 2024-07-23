require 'package'

class Tkdiff < Package
  description 'TkDiff is a graphical front end to the diff program.'
  homepage 'https://tkdiff.sourceforge.io/'
  version '5.3'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/tkdiff/tkdiff/5.3/tkdiff-5-3.zip'
  source_sha256 '193476bd40766e5c49e2e27c30dc446f97abca8b0b5fe82e6ce8af6e71ea85e7'

  depends_on 'tk'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'tkdiff', "#{CREW_DEST_PREFIX}/bin/tkdiff", mode: 0o755
  end
end
