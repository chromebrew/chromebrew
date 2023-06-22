require 'package'

class Stressng < Package
  description 'stress-ng will stress test a computer system in various selectable ways.'
  homepage 'https://kernel.ubuntu.com/~cking/stress-ng/'
  # 0.12.06 would not build as of 2021.04.07
  version '0.12.05'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-#{version}.tar.xz"
  source_sha256 'af7779aee38e6d94726ed7d5cf36384a64d50c86e42fff89c141d8609913f425'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stressng/0.12.05_armv7l/stressng-0.12.05-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stressng/0.12.05_armv7l/stressng-0.12.05-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stressng/0.12.05_i686/stressng-0.12.05-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stressng/0.12.05_x86_64/stressng-0.12.05-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c2d12f8c29ebb89709a40880f18bf29c2f1eb4e9b50f5f601e2a47aab598ef21',
     armv7l: 'c2d12f8c29ebb89709a40880f18bf29c2f1eb4e9b50f5f601e2a47aab598ef21',
       i686: '15f02f0c7819d9c3f5da89068b5c18f812f5428dabeab3ddf8f0d626ce0a8f7d',
     x86_64: 'a2b49f6d383bbfb208daf3146205ebfd8bb4aaa9f2b0fa0be76a880cf32b2c18'
  })

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
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/stressng", @env)
  end
end
