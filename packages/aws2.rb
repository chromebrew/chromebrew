require 'package'

class Aws2 < Package
  description 'This package makes it easy to start, stop and save AWS spot instances; and to manage EC2 resources.'
  homepage 'https://github.com/simonm3/aws2'
  version '0.2.7'
  revision 1
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({})
  binary_sha256({})

  depends_on 'rust' => :build
  depends_on 'python3' => :build

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I aws2==#{@version} --no-warn-script-location"
  end
end
