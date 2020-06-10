require 'package'

class Chromebeer < Package
  description 'An opinionated bundle of "essential" Chromebrew packages.'
  homepage ''
  version '1.0'
  compatibility 'all'

  is_fake

  depends_on 'ascii'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'filecmd'
  depends_on 'gawk'
  depends_on 'gzsize'
  depends_on 'lshw'
  depends_on 'mediainfo'
  depends_on 'mlocate'
  depends_on 'psmisc'
  depends_on 'rsync'
  depends_on 'sysstat'
  depends_on 'tree'
  depends_on 'unzip'
  depends_on 'zip'
  depends_on 'manpages'
end
