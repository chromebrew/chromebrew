require 'package'

class Nedit < Package
  description 'A fast, compact Motif/X11 plain text editor, for most popular Unix systems.'
  homepage 'https://sourceforge.net/projects/nedit/'
  version '5.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/nedit/nedit-source/nedit-#{version}-src.tar.gz"
  source_sha256 '5851aa7252dad952084529173640232562dec4a7c440209f196d53d4a5a8074d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53b5407afaa2e90dbb2519d3374bbd3642fb4b38829e8f0025e5d30075c0426c',
     armv7l: '53b5407afaa2e90dbb2519d3374bbd3642fb4b38829e8f0025e5d30075c0426c',
     x86_64: '1d007a9473404e669ee0f2312aaa58a72ff6fc4aa9a77d0e636a6226f68588e3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxt' => :executable
  depends_on 'motif' => :executable

  def self.patch
    system "sed -i 's/\$@/linux/g' Makefile"
  end

  def self.build
    system 'make', 'linux'
    Dir.chdir 'doc' do
      system 'make', 'man'
    end
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    FileUtils.install 'source/nc', "#{CREW_DEST_PREFIX}/bin/nc", mode: 0o755
    FileUtils.install 'source/nedit', "#{CREW_DEST_PREFIX}/bin/nedit", mode: 0o755
    FileUtils.install 'doc/nc.man', "#{CREW_DEST_MAN_PREFIX}/man1/nc.1", mode: 0o644
    FileUtils.install 'doc/nedit.man', "#{CREW_DEST_MAN_PREFIX}/man1/nedit.1", mode: 0o644
  end
end
