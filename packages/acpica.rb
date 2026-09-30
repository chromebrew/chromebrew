require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html'
  version '20260930'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/acpica/acpica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '209ad8b16d0c0a5b7cb0de17ac1405cb863de941ce2451f6d9c84d8693037362'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
