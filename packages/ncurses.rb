require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20210206-2'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'ncursesw'
  
end
