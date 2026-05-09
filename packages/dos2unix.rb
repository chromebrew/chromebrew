require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.5.5'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/dos2unix/dos2unix/#{version}/dos2unix-#{version}.tar.gz"
  source_sha256 '75f692b8484c8c24579a2ffd87df16b9c9428ed95497e3393a21d1ba0697ac33'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '832fd860faaf42e6ebd4b35bd32a780c3fcc93b6e2e3a3aa4feb26b458422066',
     armv7l: '832fd860faaf42e6ebd4b35bd32a780c3fcc93b6e2e3a3aa4feb26b458422066',
       i686: '1d8efc912cd7f7cadaca2c53aca83090615b42d446c6a9b34dab0c1ee56a94c4',
     x86_64: '2b79835d7d6633fac664f3a6c2ff65284cea523de29400a03491cd4f6b7ccf4b'
  })

  depends_on 'gettext' => :build
  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'dos2unix', "#{CREW_DEST_PREFIX}/bin/dos2unix", mode: 0o755
    FileUtils.install 'mac2unix', "#{CREW_DEST_PREFIX}/bin/mac2unix", mode: 0o755
    FileUtils.install 'unix2dos', "#{CREW_DEST_PREFIX}/bin/unix2dos", mode: 0o755
    FileUtils.install 'unix2mac', "#{CREW_DEST_PREFIX}/bin/unix2mac", mode: 0o755
  end
end
