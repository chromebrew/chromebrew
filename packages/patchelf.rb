require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.19.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '857991f1169648215918eed884356fe5579ba4aed34c23c430ad39af236389c4',
     armv7l: '857991f1169648215918eed884356fe5579ba4aed34c23c430ad39af236389c4',
       i686: '392f4e9a578ed695ec754d3aefb1ddb253f41c3928e274de2c6f67644053655a',
     x86_64: '10214c09c0d594110732b67f27fa51fd80c20544be08898ed0194d8f2248dc45'
  })

  no_env_options

  autotools_pre_configure_options "LDFLAGS='#{CREW_LINKER_FLAGS} -static'"
end
