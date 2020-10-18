require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://acpica.org/'
  version '20200925'
  compatibility 'all'
  source_url 'https://acpica.org/sites/acpica/files/acpica-unix-20200925.tar.gz'
  source_sha256 'd44388e21e3d2e47c6d39e9c897935d3f775f04fec76271dcba072c74f834589'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200925-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200925-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200925-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200925-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4fab7ff907309a9ded50cc5054d3796e6cf852c057e9eaa7f447d6d4b31dff90',
     armv7l: '4fab7ff907309a9ded50cc5054d3796e6cf852c057e9eaa7f447d6d4b31dff90',
       i686: '24ec4f3d3223ec9e43c80b3bc864d1ff2385014624c172e04051921b395e8ffc',
     x86_64: '346a75c16f86dde073cb0f22e00fc688c74b3404af8ae10726cd485c97d4f92c',
  })

  def self.build
    system 'make'
  end

  def self.install
    Dir.chdir 'generate/unix/bin' do
      system "for f in \$(ls | xargs); do install -Dm755 \$f #{CREW_DEST_PREFIX}/bin/\$f; done"
    end
  end
end
