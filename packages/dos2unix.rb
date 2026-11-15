require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.5.7'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/dos2unix/dos2unix/#{version}/dos2unix-#{version}.tar.gz"
  source_sha256 '669ee27120ae71589f638fe3a167d6ea54f8633f5ab1b282551bd7a7c9510dfa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f727dd6d70c3133e89700b88c39489e58eb05e3f44a0a67e3d80b351f88f201',
     armv7l: '6f727dd6d70c3133e89700b88c39489e58eb05e3f44a0a67e3d80b351f88f201',
       i686: 'b5e35ca706772fd1550afbd9bd08907ccc2167f160c31b986811a0a6ea312a32',
     x86_64: 'f5897a06a1f3e9908a179507e65b7b717011e932d12dae49e1be073cc37cb02f'
  })

  depends_on 'gettext' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

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
