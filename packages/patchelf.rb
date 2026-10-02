require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.19.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a858f3a6f3fd639a4bb1611ae3c7f8c26cbef82bc50576f04fc3970b75877cac',
     armv7l: 'a858f3a6f3fd639a4bb1611ae3c7f8c26cbef82bc50576f04fc3970b75877cac',
       i686: '1c33652c8fd4508ecf940bbbd725e1d170c3c9e76d62ed6cd35b232ee339db47',
     x86_64: '88c826d55772f836ecdc4be70dd46e83b527ebe363e94d067f727476dd2a3e49'
  })

  no_env_options

  autotools_pre_configure_options "LDFLAGS='#{CREW_LINKER_FLAGS} -static'"
end
