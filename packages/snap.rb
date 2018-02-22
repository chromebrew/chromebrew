require 'package'

class Snap < Package
  description 'Server stack which includes sqlite, nginx and php'
  homepage ''
  version '1.0'

  is_fake

  depends_on 'nginx'
  depends_on 'sqlite'
  depends_on 'php' unless File.exists? "#{CREW_PREFIX}/bin/php"
end
