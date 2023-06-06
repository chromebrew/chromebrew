require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '633'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url "https://greenwoodsoftware.com/less/less-#{version}.tar.gz"
  source_sha256 '2f201d64b828b88af36dfe6cfdba3e0819ece2e446ebe6224813209aaefed04f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633_armv7l/less-633-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633_armv7l/less-633-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633_i686/less-633-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633_x86_64/less-633-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0ce05f43a05e71150e80ab0663640c8802a2d9c258b9d014e293a637801ababb',
     armv7l: '0ce05f43a05e71150e80ab0663640c8802a2d9c258b9d014e293a637801ababb',
       i686: 'a18c9f5a8420cad3ff50a6b3ad3a15c507f319aec4cfc711cbde06ba8957d0a8',
     x86_64: 'fcb65cc3739f3c868cee842d0fc88e51152f52cd0ac93c00fe47c91b74944d03'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
    File.write 'lessenv', <<~LESS_ENV_EOF
      LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 --use-color'
    LESS_ENV_EOF
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'lessenv', "#{CREW_DEST_PREFIX}/etc/env.d/less", mode: 0o644
  end
end
