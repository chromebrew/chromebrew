require 'package'

class Xwayland < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://x.org'
  version '1.20.3'

  is_fake

  depends_on 'xorg_server'

end
