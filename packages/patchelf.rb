require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.18.0-523f401-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag '523f401584d9584e76c9c77004e7abeb9e6c4551'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2abcfc0a51ed852ca1ca469a32866204c806110f6a7b3c6bef785edd01507703',
     armv7l: '2abcfc0a51ed852ca1ca469a32866204c806110f6a7b3c6bef785edd01507703',
       i686: 'ef3052e4bd59d6bddbb5b9a0ae0498429a17edacb662613ff1b3b0528fb0e78d',
     x86_64: '313c3dffbec9404b609999f8e5adf71cdd601025b9dda7afb81caf500225f8bf'
  })

  no_env_options

  autotools_pre_configure_options "LDFLAGS='#{CREW_LINKER_FLAGS} -static'"

  def self.check
    system "#{CREW_DEST_PREFIX}/bin/patchelf --version"
  end
end
