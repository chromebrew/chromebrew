require 'package'

class Stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.3.1'
  license 'GPL-3+'
  compatibility 'all'

  depends_on 'perl_stow'

  is_fake
end
