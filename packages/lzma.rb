require 'package'
require_relative 'xzutils'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio. Bundled with xzutils.'
  homepage 'https://tukaani.org/lzma/'
  version Xzutils.version
  license Xzutils.license
  compatibility Xzutils.compatibility

  is_fake

  depends_on 'xzutils'
end
