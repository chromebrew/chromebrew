require 'package'
require_relative 'moreutils'

class Parallel < Package
  description 'Run multiple programs simultaneously. Bundled with moreutils.'
  homepage Moreutils.homepage.to_s
  version Moreutils.version.to_s
  license Moreutils.license.to_s
  compatibility Moreutils.compatibility.to_s

  is_fake

  depends_on 'moreutils'
end
