require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.19.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5423361292ce6a2192b563fd1469f531d8ce7e93ee5071dd051f6fc5507634bc',
     armv7l: '5423361292ce6a2192b563fd1469f531d8ce7e93ee5071dd051f6fc5507634bc',
       i686: '60ed25c8c8c745472a4317c52b454064bffdf6718884adc03f09ae012ea7e7ee',
     x86_64: '8ff7b727fc0f003bb752cefe8afcf76c1933b9ecc7865f39425ea4edc09dc569'
  })

  no_env_options

  autotools_pre_configure_options "LDFLAGS='#{CREW_LINKER_FLAGS} -static'"
end
