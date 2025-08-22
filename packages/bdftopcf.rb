require 'buildsystems/autotools'

class Bdftopcf < Autotools
  description 'BDF to PCF font converter for X11'
  homepage 'https://gitlab.freedesktop.org/xorg/util/bdftopcf'
  version '1.1.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/util/bdftopcf.git'
  git_hashtag "bdftopcf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f1d5c6fdac79e9942697366245581e02abe57e443a097457e72d73b97a8268e',
     armv7l: '6f1d5c6fdac79e9942697366245581e02abe57e443a097457e72d73b97a8268e',
     x86_64: '3b4e830fe228f6328f489e3786d7aa18a5c5eb6aa9ae881605cddc35b1c063c2'
  })

  depends_on 'glibc' # R
  depends_on 'libxfont'
  depends_on 'xorg_macros' => :build
end
