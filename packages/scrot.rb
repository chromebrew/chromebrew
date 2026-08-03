require 'buildsystems/autotools'

class Scrot < Autotools
  description 'scrot, an acronym for (SCReen shOT) is a simple, freely distributed and open source command-line screen capture utility'
  homepage 'https://github.com/resurrecting-open-source-projects/scrot'
  version '2.0.0'
  license 'feh and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/resurrecting-open-source-projects/scrot.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e7db7044752a4f8a7d9450377ab1f71984e285d2af91815d46341643a184c4d',
     armv7l: '4e7db7044752a4f8a7d9450377ab1f71984e285d2af91815d46341643a184c4d',
     x86_64: 'b72f4e64f666f330a8938c35215139081754b0443b053ce8b25100cfa4f78845'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'giblib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'imlib2' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcomposite' => :executable
  depends_on 'libxcursor' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'optipng' => :executable
end
