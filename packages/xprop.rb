require 'buildsystems/autotools'

class Xprop < Autotools
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/wiki/'
  version '1.2.8'
  license 'MIT-with-advertising and ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xprop.git'
  git_hashtag "xprop-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa7f965ada21f80c281ef53ba828734bad11f86193e66a4afa3fd7614405d583',
     armv7l: 'fa7f965ada21f80c281ef53ba828734bad11f86193e66a4afa3fd7614405d583',
     x86_64: '9204c99c67b14ff58b687ed8e18be279a359b0433b3d37d5db1573adb1e5560b'
  })

  depends_on 'glibc' => :library
  depends_on 'libx11' => :library
end
