require 'package'

class Chromebeer < Package
  description 'An opinionated bundle of "essential" Chromebrew packages.'
  homepage ''
  version '1.1'
  compatibility 'all'

  is_fake

  depends_on 'ascii'
  depends_on 'bleachbit'
  depends_on 'clear_cache'
  depends_on 'gzsize'
  depends_on 'lshw'
  depends_on 'mediainfo'
  depends_on 'mlocate'
  depends_on 'ncdu'
  depends_on 'psmisc'
  depends_on 'rsync'
  depends_on 'sysstat'
  depends_on 'tree'
  depends_on 'util_linux'
end
