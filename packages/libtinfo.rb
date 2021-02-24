require 'package'

class Libtinfo < Package
  description 'An old package kept for compatibility purposes.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2'
  compatibility 'all'
  is_fake

  depends_on 'ncurses'

end
