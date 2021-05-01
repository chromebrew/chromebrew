require 'package'

class Speexdsp < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2rc3-1'
  license 'BSD'
  compatibility 'all'
  source_url 'http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz'
  source_sha256 '4ae688600039f5d224bdf2e222d2fbde65608447e4c2f681585e4dca6df692f1'

  is_fake
  
  depends_on 'speex'

end
