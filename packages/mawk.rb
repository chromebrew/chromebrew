require 'buildsystems/autotools'

class Mawk < Autotools
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://invisible-island.net/mawk/'
  version '1.3.4-20260129'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://invisible-island.net/archives/mawk/mawk-#{version}.tgz"
  source_sha256 'a71fb7efea5a63770d8fb71321ef6ae7afe0592f1aa7f7e2b496c26ccbb392a4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b295b0d2dfbaf2f2a6e61622ccbbdfc9c0f256cf503082d0014a0074825dd105',
     armv7l: 'b295b0d2dfbaf2f2a6e61622ccbbdfc9c0f256cf503082d0014a0074825dd105',
       i686: '68a5e7a8a03274630260ca303a20fea170a918afa1b8c469840cafdc0235b1c0',
     x86_64: 'f6352afff896d6dc3d964e3c5422a290b5b0cfea053e520c096765563da34c39'
  })

  depends_on 'glibc' # R

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/mawk", "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
