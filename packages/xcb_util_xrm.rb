require 'buildsystems/autotools'

class Xcb_util_xrm < Autotools
  description 'XCB utility functions for the X resource manager'
  homepage 'https://github.com/Airblader/xcb-util-xrm'
  version '1.3-2'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT-with-advertising'
  source_url 'https://github.com/Airblader/xcb-util-xrm.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95e5da6b9813e3395a3ee77aa34e47c966dc77e3f035b409fa09c862272db963',
     armv7l: '95e5da6b9813e3395a3ee77aa34e47c966dc77e3f035b409fa09c862272db963',
     x86_64: '0fba4c6710557d350cb45cecea726084294835f1b3c7e1887487e594d83a9aec'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' => :build
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
end
