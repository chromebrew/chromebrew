require 'buildsystems/autotools'

class Xhost < Autotools
  description 'Server access control program for X'
  homepage 'https://github.com/freedesktop/xorg-xhost'
  version '1.0.10'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xhost.git'
  git_hashtag "xhost-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8d3a228a19525ccecf38bc5b213a220dba83d8e7717d43a4193b828f89e3556',
     armv7l: 'b8d3a228a19525ccecf38bc5b213a220dba83d8e7717d43a4193b828f89e3556',
     x86_64: '5bed726a341d3a6f9c6bdbc54cb68c008f08fbae8c4ffc200de30cee08deb529'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxmu' # R
  depends_on 'libxtrans' => :build
end
