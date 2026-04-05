require 'buildsystems/autotools'

class Xrdb < Autotools
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org/wiki/'
  version '1.2.2'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb257fc3893fd675a1172698eb77af04bc125eaa7a4c60acd5bd90b6cfb2f175',
     armv7l: 'eb257fc3893fd675a1172698eb77af04bc125eaa7a4c60acd5bd90b6cfb2f175',
     x86_64: '58c2b739970d8895579598230fc6fab28744b590f2e50acdd11abc6c5159f0c8'
  })

  depends_on 'glibc' => :library
  depends_on 'libx11' => :library
  depends_on 'libxdmcp' => :build
  depends_on 'libxmu' => :library
end
