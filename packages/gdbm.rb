require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  @_ver = '1.19'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gdbm/gdbm-#{@_ver}.tar.gz"
  source_sha256 '37ed12214122b972e18a0d94995039e57748191939ef74115b1d41d8811364bc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.19_armv7l/gdbm-1.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.19_armv7l/gdbm-1.19-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.19_i686/gdbm-1.19-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdbm/1.19_x86_64/gdbm-1.19-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '34ed01ff6f5ce4af6e8d89f54acbd74cd2b33c585c4409d5d6d77fcbedf0562b',
     armv7l: '34ed01ff6f5ce4af6e8d89f54acbd74cd2b33c585c4409d5d6d77fcbedf0562b',
       i686: '1042907927b4b62f49ec959f317273b27a380d264a5ea690070b4643528e33f8',
     x86_64: '79ffa73dfefefdec13bfd9ccaac27f24e6bd6b86da4efd6b0544f45a6828ad51'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R

  def self.build
    system "./configure \
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
