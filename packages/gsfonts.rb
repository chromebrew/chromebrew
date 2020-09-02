require 'package'

class Gsfonts < Package
  description 'Ghostscript standard Type1 fonts'
  homepage 'https://sourceforge.net/projects/gs-fonts/'
  version '8.11'
  compatibility 'all'
  source_url 'https://managedway.dl.sourceforge.net/project/ghostscript/AFPL%20Ghostscript/8.14/ghostscript-fonts-std-8.11.tar.gz'
  source_sha256 '0eb6f356119f2e49b2563210852e17f57f9dcc5755f350a69a46a0d641a0c401'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsfonts-8.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsfonts-8.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsfonts-8.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsfonts-8.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd8f867e14daa6927137142e6ab5d72ca3116981371608a09674191b22ab7be4',
     armv7l: 'fd8f867e14daa6927137142e6ab5d72ca3116981371608a09674191b22ab7be4',
       i686: '94aef1978a722ce0a1db47df57107b73bc050e7af6a146aa36cbbdc1188e19cf',
     x86_64: 'd3f1bbb62b07cd5a0da5c83105d86718f3827415be95df0b5f0d988b651a0466',
  })

  depends_on 'font_util'
  depends_on 'font_misc_misc'
  depends_on 'bdftopcf'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/fonts/Type1"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/fonts/Type1"
  end
end
