require 'package'
require_relative 'moreutils'

class Parallel < Package
  description 'Run multiple programs simultaneously. Bundled with moreutils.'
  homepage Moreutils.homepage
  version Moreutils.version
  license Moreutils.license
  compatibility Moreutils.compatibility

  is_fake

  depends_on 'moreutils'
end
