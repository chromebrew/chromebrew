require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  @_ver = '1.23'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gdbm/gdbm-#{@_ver}.tar.gz"
  source_sha256 '74b1081d21fff13ae4bd7c16e5d6e504a4c26f7cde1dca0d963a484174bbcacd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.23_armv7l/gdbm-1.23-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.23_armv7l/gdbm-1.23-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.23_i686/gdbm-1.23-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.23_x86_64/gdbm-1.23-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f0220b8db665e3ae6cb1ad8bcdf857412ed30f57d959df46cc5239095b4248bc',
     armv7l: 'f0220b8db665e3ae6cb1ad8bcdf857412ed30f57d959df46cc5239095b4248bc',
       i686: 'c7c6d8d62f231088d689c1ac890e5fde6ef236056b697ad7dbf75f7845f6d32e',
     x86_64: 'fac97319de143626cd10e33d84c3618f58fa32cd814460b6287af7d8ada36b3b'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "mold -run ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
