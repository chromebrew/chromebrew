require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.18.0-523f401'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag '523f401584d9584e76c9c77004e7abeb9e6c4551'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6013578363f4949ba003a9baf6cdf4494ffdab85dfa141d231c7111be4841c19',
     armv7l: '6013578363f4949ba003a9baf6cdf4494ffdab85dfa141d231c7111be4841c19',
       i686: '35c23d10350f3a29111831776d639f8b53cd987c262868188987e27fef8b8cae',
     x86_64: '36b45b4f59b426a875e8db833595d7377c960a701f4153e1b2dcc786389458fd'
  })

  no_env_options

  pre_configure_options "LDFLAGS='#{CREW_LINKER_FLAGS} -static'"

  def self.check
    system "#{CREW_DEST_PREFIX}/bin/patchelf --version"
  end
end
