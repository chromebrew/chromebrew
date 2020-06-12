require 'package'

class Tkdiff < Package
  description 'TkDiff is a graphical front end to the diff program.'
  homepage 'https://tkdiff.sourceforge.io/'
  version '4.3.5'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/tkdiff/tkdiff/4.3.5/tkdiff-4-3-5.zip'
  source_sha256 '29d7f0b815d06b0ab6653baa9b6b7c213801ce6a976724ae843bf9735cbbde7e'

  depends_on 'tk'

  def self.install
    system "install -Dm755 tkdiff #{CREW_DEST_PREFIX}/bin/tkdiff"
  end
end
