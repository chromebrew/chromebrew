require 'package'

class Gsfonts < Package
  description 'Ghostscript standard Type1 fonts'
  homepage 'https://sourceforge.net/projects/gs-fonts/'
  version '8.11'
  compatibility 'all'
  source_url 'https://managedway.dl.sourceforge.net/project/ghostscript/AFPL%20Ghostscript/8.14/ghostscript-fonts-std-8.11.tar.gz'
  source_sha256 '0eb6f356119f2e49b2563210852e17f57f9dcc5755f350a69a46a0d641a0c401'

  depends_on 'font_util'
  depends_on 'font_misc_misc'
  depends_on 'bdftopcf'
  
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/fonts/Type1"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/fonts/Type1"
  end
end
