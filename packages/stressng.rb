require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  version '0.12.06'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.12.06.tar.xz'
  source_sha256 '75eb340266b1bbae944d8f9281af978bd5bc2c8085df97a098d5500d6f177296'

  depends_on 'libbsd'

  def self.build
    system "make \
      BINDIR=#{CREW_PREFIX}/bin \
      MANDIR=#{CREW_PREFIX}/share/man/man1 \
      JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs \
      BASHDIR=#{CREW_PREFIX}/share/bash-completion/completions \
      CFLAGS='-pipe -flto=auto -fuse-ld=gold'"
  end

  def self.install
    system "make \
      DESTDIR=#{CREW_DEST_DIR} \
      BINDIR=#{CREW_PREFIX}/bin \
      MANDIR=#{CREW_PREFIX}/share/man/man1 \
      JOBDIR=#{CREW_PREFIX}/share/stress-ng/example-jobs \
      BASHDIR=#{CREW_PREFIX}/share/bash-completion/completions \
      CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # stressng bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/stress-ng
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/stressng", @env)
  end
end
