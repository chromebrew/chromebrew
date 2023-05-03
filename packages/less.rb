require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '633-35aac3f'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://github.com/gwsw/less.git'
  git_hashtag '35aac3f11104ed597886d05fa9d3264387c3f6e6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633-35aac3f_armv7l/less-633-35aac3f-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633-35aac3f_armv7l/less-633-35aac3f-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633-35aac3f_i686/less-633-35aac3f-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/633-35aac3f_x86_64/less-633-35aac3f-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b283871b97bfd389e0fa51162ed5a8cf8fcf7d0e9cd83d823790cf401f726108',
     armv7l: 'b283871b97bfd389e0fa51162ed5a8cf8fcf7d0e9cd83d823790cf401f726108',
       i686: '707d064aef30f451325ab2afbd88b4dee2154e7cfe99b3e02ddd042b468928ec',
     x86_64: '2614ec735bf3b05b20fbef0ecfe9a6553b1564b7e385d803d9771041b59572ea'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc' # R

  def self.build
    system 'make -f Makefile.aut distfiles'
    system "./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
    File.write 'lessenv', <<~LESS_ENV_EOF
      PAGER=#{CREW_PREFIX}/bin/less
      LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 --use-color'
    LESS_ENV_EOF
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'lessenv', "#{CREW_DEST_PREFIX}/etc/env.d/less", mode: 0o644
  end

  def self.postinstall
    puts 'The default PAGER has been set to less.'.lightblue
  end
end
