require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html'
  version '20260408'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/acpica/acpica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '444bc48db103c16a2951f19ba843a2537bc31f642ff2b1dcc075b741efef33d7'
  })

  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
