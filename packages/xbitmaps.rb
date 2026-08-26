require 'buildsystems/autotools'

class Xbitmaps < Autotools
  description 'The xbitmaps package contains bitmap images used by multiple applications built in Xorg chapter.'
  homepage 'https://www.x.org/wiki/'
  version '1.1.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/data/bitmaps.git'
  git_hashtag "xbitmaps-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21a7f827b9da7535aa566347e69303c9bf0adce2710956b411bbf79162b54cc1',
     armv7l: '21a7f827b9da7535aa566347e69303c9bf0adce2710956b411bbf79162b54cc1',
       i686: '3f9f0600965349a85bdef8977d3d1ed6b02e377529b784f9ac907a29b08c542d',
     x86_64: '16031a128e126aa971f934989e25f43351a99b6a88bd03704b9b5dfe403f6c54'
  })

  depends_on 'xorg_macros' => :build
end
