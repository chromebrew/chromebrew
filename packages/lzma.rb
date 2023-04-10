require 'package'
require_relative 'xzutils'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio. Bundled with xzutils.'
  homepage 'https://tukaani.org/lzma/'
  version Xzutils.version.to_s
  license Xzutils.license.to_s
  compatibility Xzutils.compatibility.to_s

  is_fake

  depends_on 'xzutils'
end
