require 'buildsystems/autotools'

class Xcb_util_xrm < Autotools
  description 'XCB utility functions for the X resource manager'
  homepage 'https://github.com/Airblader/xcb-util-xrm'
  version '1.3-2'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://github.com/Airblader/xcb-util-xrm.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70cdd52679ee61272c4f07bcc1bc75132512415004011e67dc844ca26c22e5e6',
     armv7l: '70cdd52679ee61272c4f07bcc1bc75132512415004011e67dc844ca26c22e5e6',
       i686: '85e432baec61c1092613482a57fba8b4e159458680c09e28e3239213b375d579',
     x86_64: '0fba4c6710557d350cb45cecea726084294835f1b3c7e1887487e594d83a9aec'
  })

  depends_on 'glibc' # R
  depends_on 'libxau' # R

end
