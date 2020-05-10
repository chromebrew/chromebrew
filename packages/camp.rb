require 'package'

class Camp < Package
  description 'Server stack which includes httpd, percona_server and php'
  homepage ''
  version '1.0'
  compatibility 'all'

  is_fake

  depends_on 'httpd'
  depends_on 'percona_server'
  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"
end
