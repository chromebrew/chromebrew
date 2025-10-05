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
    aarch64: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
     armv7l: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
       i686: 'd2fb32097557b95a2c824a1c5cdd3b3fd515ef99c5294350e6c6443ee0190cb0',
     x86_64: '5bed726a341d3a6f9c6bdbc54cb68c008f08fbae8c4ffc200de30cee08deb529'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxmu' # R
  depends_on 'libxtrans' => :build
end
