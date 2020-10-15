require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://acpica.org/'
  version '20200925'
  compatibility 'all'
  source_url 'https://acpica.org/sites/acpica/files/acpica-unix-20200925.tar.gz'
  source_sha256 'd44388e21e3d2e47c6d39e9c897935d3f775f04fec76271dcba072c74f834589'

  binary_url ({
  })
  binary_sha256 ({
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
