require 'package'

class Aws2 < Package
  description 'This package makes it easy to start, stop and save AWS spot instances; and to manage EC2 resources.'
  homepage 'https://github.com/simonm3/aws2'
  @_ver='0.2.7'
  version @_ver + '-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e7f09c31b8c152ea015a002c2f2dc8745f0e2ec01cc21cc5fd92afb6b97e24a4'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'rust' => :build
  depends_on 'setuptools' => :build

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I aws2==#{@_ver} --no-warn-script-location"
  end
end
