require 'buildsystems/autotools'

class Xrdb < Autotools
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org/wiki/'
  version '1.2.3'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a613e9e6d36caf07de251917178ffccb2843d8ac58d6b0157941b15532e74af4',
     armv7l: 'a613e9e6d36caf07de251917178ffccb2843d8ac58d6b0157941b15532e74af4',
     x86_64: '703ca4fd6a8a5b2236eabbdf75f27d10e0934aa3dcd81981017cf72ab40dba8f'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxdmcp' => :build
  depends_on 'libxmu' => :executable
  depends_on 'libxmu' => :library
end
