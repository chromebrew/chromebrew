require 'package'

class Moonbuggy < Package
  description 'Moon-buggy is a simple character graphics game where you drive some kind of car across the moon\'s surface.'
  homepage 'http://www.seehuhn.de/pages/moon-buggy'
  version '1.0.51'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://m.seehuhn.de/programs/moon-buggy-1.0.51.tar.gz'
  source_sha256 '352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/moonbuggy/1.0.51_armv7l/moonbuggy-1.0.51-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/moonbuggy/1.0.51_armv7l/moonbuggy-1.0.51-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/moonbuggy/1.0.51_i686/moonbuggy-1.0.51-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/moonbuggy/1.0.51_x86_64/moonbuggy-1.0.51-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ed1a664522ac06317afefa478572efebe80f9cbf99fd06a3bc0353b5b46af221',
     armv7l: 'ed1a664522ac06317afefa478572efebe80f9cbf99fd06a3bc0353b5b46af221',
       i686: '8bae57552d87d4a6cd65b10ff7f8d20baeb5297c4d8f292550b58d50710ec46d',
     x86_64: '190a6a121463f1c00549c319cffa59272e8d5ec1cbed0868c9232131874130ee'
  })

  depends_on 'ncurses'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
