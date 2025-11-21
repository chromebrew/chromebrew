require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html'
  version '20250807'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/acpica/acpica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '2ed7312f5e2787c778c5157c16dadfa4aadb5afb88cfd0a44657318c5aaadf4d'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
