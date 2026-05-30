require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.5.6'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/dos2unix/dos2unix/#{version}/dos2unix-#{version}.tar.gz"
  source_sha256 '63650acbd0c7fa8623429bcbf93a888e3351a1cad0f556cf41876f5673dd7d0b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f0e89fc7dbcba536fd04206cb48505a6fcfec1a2bb86bb7c6c80d54566c58e3',
     armv7l: '1f0e89fc7dbcba536fd04206cb48505a6fcfec1a2bb86bb7c6c80d54566c58e3',
       i686: 'ea5232af84ba74e325dab5eea6f39cb0af10e5c4bf46c0f8488e13e4a7aa3427',
     x86_64: '5d099d6e4a599311e3f94c7c51765ee1e391db717a3fd0129112be671c388b11'
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
