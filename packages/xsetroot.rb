require 'buildsystems/autotools'

class Xsetroot < Autotools
  description 'Root window parameter setting utility for X'
  homepage 'https://www.x.org/archive/X11R7.5/doc/man/man1/xsetroot.1.html'
  version '1.1.4'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xsetroot.git'
  git_hashtag "xsetroot-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3e69faeca8831ee02bcb4ebb4cd9e2f25a9f2bd0a21dc1731a5ffca5dded3e8',
     armv7l: 'e3e69faeca8831ee02bcb4ebb4cd9e2f25a9f2bd0a21dc1731a5ffca5dded3e8',
     x86_64: 'eee714d9b3d7eb223a743cfced328b6b2fdf8eeb8ae9e4e57ab6a4a728f9cf1d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcursor' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'xbitmaps' => :build
end
