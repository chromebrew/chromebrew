require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html'
  version '20250404'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/acpica/acpica.git'
  git_hashtag 'R2025_04_04'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fab7ff907309a9ded50cc5054d3796e6cf852c057e9eaa7f447d6d4b31dff90',
     armv7l: '4fab7ff907309a9ded50cc5054d3796e6cf852c057e9eaa7f447d6d4b31dff90',
       i686: '24ec4f3d3223ec9e43c80b3bc864d1ff2385014624c172e04051921b395e8ffc',
     x86_64: '346a75c16f86dde073cb0f22e00fc688c74b3404af8ae10726cd485c97d4f92c'
  })

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
