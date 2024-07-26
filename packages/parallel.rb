require 'package'
Package.load_package("#{__dir__}/moreutils.rb")

class Parallel < Package
  description 'Run multiple programs simultaneously. Bundled with moreutils.'
  homepage Moreutils.homepage
  version Moreutils.version
  license Moreutils.license
  compatibility Moreutils.compatibility

  is_fake

  depends_on 'moreutils'
end
