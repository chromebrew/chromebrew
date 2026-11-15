require 'package'

class Zsync < Package
  description 'zsync is a client-side file transfer program similar to rsync.'
  homepage 'http://zsync.moria.org.uk/'
  version '0.8.0'
  license 'Artistic-2'
  compatibility 'all'
  source_url "https://zsync.moria.org.uk/download/zsync-#{version}.tar.gz"
  source_sha256 '58b02f27e14326b62b7fdd6ed431a3e243b1c5a3ea9e3c1678e136dbf00c238d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '962ac9cfb9254758c9cfea7e9c3f4887b7e5ea3b9349722c9040714b550d609f',
     armv7l: '962ac9cfb9254758c9cfea7e9c3f4887b7e5ea3b9349722c9040714b550d609f',
       i686: 'e0cf3eb430b914ba711e7aa81c421a7073b60e3952bd02d4efc537dd1dae20b9',
     x86_64: 'bab028f04261c378eebbbc369176a3ff99d877eade56e1aceb62778b11600572'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "go build -o #{CREW_DEST_PREFIX}/bin/zsync ./cmd/zsync"
    system "go build -o #{CREW_DEST_PREFIX}/bin/zsyncmake ./cmd/zsyncmake"
    FileUtils.install Dir['man/zsync*.1'], "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o644
  end
end
