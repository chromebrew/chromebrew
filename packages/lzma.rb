require 'package'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio.'
  homepage 'https://tukaani.org/lzma/'
  version '4.98'
  license 'public-domain'
  compatibility 'all'

  is_fake

  depends_on 'xzutils'
end
