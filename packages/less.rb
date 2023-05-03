require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '633x-35aac3f'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://github.com/gwsw/less.git'
  git_hashtag '35aac3f11104ed597886d05fa9d3264387c3f6e6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633x-35aac3f_armv7l/less-633x-35aac3f-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633x-35aac3f_armv7l/less-633x-35aac3f-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633x-35aac3f_i686/less-633x-35aac3f-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633x-35aac3f_x86_64/less-633x-35aac3f-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '400dd810afa42f62d45fe724aa1f8eb5df1c3491731f4f3cc70bd21c09d0e96c',
     armv7l: '400dd810afa42f62d45fe724aa1f8eb5df1c3491731f4f3cc70bd21c09d0e96c',
       i686: '31bf6c9a0f46b70d99626c94ec8f59c92603574fa1be10fe48495ecf76368e79',
     x86_64: '421e919875a8b600cd710aba4d910b64f6767217c1cf8387bfa419ee0d656573'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc' # R

  def self.build
    system 'make -f Makefile.aut distfiles'
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
