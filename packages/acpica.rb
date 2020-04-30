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
    system "install -Dm755 generate/unix/bin/iasl #{CREW_DEST_PREFIX}/bin/iasl"
    system "install -Dm755 generate/unix/bin/acpixtract #{CREW_DEST_PREFIX}/bin/acpixtract"
    system "install -Dm755 generate/unix/bin/acpisrc #{CREW_DEST_PREFIX}/bin/acpisrc"
    system "install -Dm755 generate/unix/bin/acpinames #{CREW_DEST_PREFIX}/bin/acpinames"
    system "install -Dm755 generate/unix/bin/acpihelp #{CREW_DEST_PREFIX}/bin/acpihelp"
    system "install -Dm755 generate/unix/bin/acpiexec #{CREW_DEST_PREFIX}/bin/acpiexec"
    system "install -Dm755 generate/unix/bin/acpiexamples #{CREW_DEST_PREFIX}/bin/acpiexamples"
    system "install -Dm755 generate/unix/bin/acpidump #{CREW_DEST_PREFIX}/bin/acpidump"
    system "install -Dm755 generate/unix/bin/acpibin #{CREW_DEST_PREFIX}/bin/acpibin"
  end
end
