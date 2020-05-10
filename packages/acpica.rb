require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://acpica.org/'
  version '20200326'
  source_url 'https://acpica.org/sites/acpica/files/acpica-unix2-20200326.tar.gz'
  source_sha256 '7e0d38d088ff4b2114d08e76201e000091d5a4af40ce7275950759299ba10878'

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
