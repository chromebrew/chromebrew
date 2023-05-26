require 'package'

class Liburcu < Package
  description 'Userspace RCU (read-copy-update) library.'
  homepage 'https://liburcu.org/'
  version '0.14.0-1'
  license 'LGPLv2.1'
  compatibility 'all'
  source_url 'https://lttng.org/files/urcu/userspace-rcu-0.14.0.tar.bz2'
  source_sha256 'ca43bf261d4d392cff20dfae440836603bf009fce24fdc9b2697d837a2239d4f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0-1_armv7l/liburcu-0.14.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0-1_armv7l/liburcu-0.14.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0-1_i686/liburcu-0.14.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liburcu/0.14.0-1_x86_64/liburcu-0.14.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '90303fe8c2a4fdea90b11e31a1bd2af1ea5eb5fa7f1907d472fb8d503a644e3f',
     armv7l: '90303fe8c2a4fdea90b11e31a1bd2af1ea5eb5fa7f1907d472fb8d503a644e3f',
       i686: '87f22d24a02247254b1253eac842289fe68ee784b1647ddf54a69679fe3cce42',
     x86_64: '0bfdea557de87cca76e6bf6735ef32b942a349f5e8627dd66f4e3c9aa89870fe'
  })

  depends_on 'glibc' # R

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
