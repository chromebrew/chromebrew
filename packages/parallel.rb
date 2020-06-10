require 'package'

class Parallel < Package
  description 'Run multiple programs simultaneously.'
  homepage 'https://joeyh.name/code/moreutils/'
  version '0.60'
  compatibility 'all'

  is_fake

  depends_on 'moreutils'
end
