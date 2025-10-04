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
    aarch64: 'c126d133d112220e9b055f58ac5f71970344df4e88d5475d5005252914fe3ae0',
     armv7l: 'c126d133d112220e9b055f58ac5f71970344df4e88d5475d5005252914fe3ae0',
       i686: '907304652a1d986d6864498115d980d4b9ed73939a9b8f2f8ae2772ad373ee90',
     x86_64: '4365db9d4e3397c9c1f48d6366c44a6351b19a9a1dafb142fb65e7d614b36a6e'
  })

  autotools_configure_options "#{'--disable-pidwait' if ARCH == 'i686'}"
end
