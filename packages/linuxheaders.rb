require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org'
  version '0.1'

  is_fake

  depends_on 'linux_sources'

end
