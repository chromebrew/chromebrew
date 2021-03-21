require 'package'

class Snap < Package
  description 'Server stack which includes sqlite, nginx and php. Not to be confused with snapd.'
  homepage ''
  version '1.0'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  depends_on 'nginx'
  depends_on 'sqlite'
  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"
end
