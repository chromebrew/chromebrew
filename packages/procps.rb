require 'buildsystems/autotools'

class Procps < Autotools
  description 'procps is a set of command line and full-screen utilities that provide information out of the pseudo-filesystem most commonly located at /proc.'
  homepage 'https://gitlab.com/procps-ng/procps'
  version '4.0.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/procps-ng/procps.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a31ef07767fde20684c0c5c23c9d47d6e7b646906bb3fa5db2f61794f4297625',
     armv7l: 'a31ef07767fde20684c0c5c23c9d47d6e7b646906bb3fa5db2f61794f4297625',
       i686: '71bd241f9913074041d15480c6aba8f91f8af7bbc27b8815d8cdbf022c82b31f',
     x86_64: 'f4919b4b88cf3d83a361304b74c5202754d7588b440c9bf8cb6579868c0c82ef'
  })

  conflicts_ok # Conflicts with uutils_coreutils.

  autotools_configure_options ('--disable-pidwait' if ARCH == 'i686').to_s
end
