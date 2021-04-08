require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  # 0.12.06 would not build as of 2021.04.07
  @_ver = '0.12.05'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-#{@_ver}.tar.xz"
  source_sha256 'af7779aee38e6d94726ed7d5cf36384a64d50c86e42fff89c141d8609913f425'

  depends_on 'libbsd'

  def self.patch
    system "sed -i 's:BINDIR=/usr/bin:BINDIR=#{CREW_PREFIX}/bin:' Makefile"
    system "sed -i 's:MANDIR=/usr/share/man/man1:MANDIR=#{CREW_MAN_PREFIX}/man1:' Makefile"
    system "sed -i 's:JOBDIR=/usr/share/stress-ng/example-jobs:JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs:' Makefile"
    system "sed -i 's:BASHDIR=/usr/share/bash-completion/completions:BASHDIR=#{CREW_PREFIX}/share/bash-completion/completions:' Makefile"
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
                CC='gcc' \
            make"
  end

  def self.install
    system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
                CC='gcc' \
            make DESTDIR=#{CREW_DEST_DIR} install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # stressng bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/stress-ng
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/stressng", @env)
  end
end
