require 'buildsystems/autotools'

class Font_util < Autotools
  description 'Tools for truncating and subseting of ISO10646-1 BDF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/util'
  version '1.4.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/font/util.git'
  git_hashtag "font-util-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b83ecd6672fb870c4cad80b6492b5536fec3df82960e5ed66635c3061151600',
     armv7l: '3b83ecd6672fb870c4cad80b6492b5536fec3df82960e5ed66635c3061151600',
       i686: '75eae3617d4add8b1a060ecbd3d1a1da5e9c5154df45fdfd0fe14e25482b0f07',
     x86_64: '63d511ff979e9e8af5dba620d259780e04e4003f988cffaf4f9f5c14f049048d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'xorg_macros' => :build

  autotools_configure_options "--with-fontrootdir=#{CREW_PREFIX}/share/fonts"
end
