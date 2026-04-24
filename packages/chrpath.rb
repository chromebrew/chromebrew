require 'buildsystems/autotools'

class Chrpath < Autotools
  description 'Change or delete the rpath or runpath in ELF files'
  homepage 'https://codeberg.org/pere/chrpath'
  version '0.18'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://codeberg.org/pere/chrpath.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34bfc9c812f5f2a307943ce02a62c21877a71224d2e0b1fc4e130789ccefad3f',
     armv7l: '34bfc9c812f5f2a307943ce02a62c21877a71224d2e0b1fc4e130789ccefad3f',
       i686: 'ca41ca56d462b3ae1ea3d61ccd0a134ae5eb7eee20c767f5c398b7a226f7cfdf',
     x86_64: '5636d867e8c09cde4a7dfccd3f518af7d8dbdf7d9a2ba483a5dc0cd3765bd772'
  })

  depends_on 'glibc' => :executable

  autotools_install_extras do
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/doc"
  end
end
