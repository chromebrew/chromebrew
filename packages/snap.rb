require 'package'

class Snap < Package
  description 'Server stack which includes sqlite, nginx and php. Not to be confused with snapd.'
  homepage ''
  version '1.1'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  depends_on 'nginx'
  depends_on 'sqlite'
  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"
end
