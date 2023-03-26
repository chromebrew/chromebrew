require 'package'

class Liburcu < Package
  description 'Userspace RCU (read-copy-update) library.'
  homepage 'https://liburcu.org/'
  version '0.14.0'
  license 'LGPLv2.1'
  compatibility 'all'
  source_url 'https://lttng.org/files/urcu/userspace-rcu-0.14.0.tar.bz2'
  source_sha256 'ca43bf261d4d392cff20dfae440836603bf009fce24fdc9b2697d837a2239d4f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0_armv7l/liburcu-0.14.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0_armv7l/liburcu-0.14.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0_i686/liburcu-0.14.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0_x86_64/liburcu-0.14.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4b12196ebba550d2e9fea11919e129a70f86314252d6ac76742b8c745e84b81a',
     armv7l: '4b12196ebba550d2e9fea11919e129a70f86314252d6ac76742b8c745e84b81a',
       i686: 'defda632879a395f5a3fea5c9f5f2e6bcd819945dff1d2d6266242e84800afdf',
     x86_64: '55d5d07fa0ba95f29d61c992901dd0ffa9112732a51f49a24e69c2d352844d8d'
  })

  def self.patch
    system 'filefix' # Fix /usr/bin/file: No such file or directory
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
