require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  @_ver = '1.4.9'
  version "#{@_ver}-py3.12"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{@_ver}.tar.gz"
  source_sha256 '0ac226073e3a2db8648da7af744cb95f50766a52feeb001d558b2b321b74a765'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.9-py3.12_armv7l/tdb-1.4.9-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.9-py3.12_armv7l/tdb-1.4.9-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.9-py3.12_i686/tdb-1.4.9-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.9-py3.12_x86_64/tdb-1.4.9-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a937908bc82109fc519b31cbe0c983a49743391a535817bb71f654ba4445aa0a',
     armv7l: 'a937908bc82109fc519b31cbe0c983a49743391a535817bb71f654ba4445aa0a',
       i686: '9074d39c76710f9b38922b6b5b149fe7cdafc8f66594f194b90c71f8478a2e99',
     x86_64: '0be9b8c54b76cb5a86da7f636ca3b38b2f80a41367fcb437923df0767e3473c8'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxslt' => :build
  depends_on 'python3' => :build

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
