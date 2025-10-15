require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.3.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '353b01f8d423aa4580e5ec6f5ea56664c91a3ede89125686866b256f4e0d3013',
     armv7l: '353b01f8d423aa4580e5ec6f5ea56664c91a3ede89125686866b256f4e0d3013',
       i686: 'b8386e36d404726675ca078f71cb308a3be271d391c438086c09704c5efe4c82',
     x86_64: 'b5b0df3a389481dbec05bad847970979f45ee9275d6bbb3ba864276c3a5084f4'
  })

  depends_on 'glibc' # R
end
