require 'package'

class Acpica < Package
  description 'ACPI tools, including Intel ACPI Source Language compiler'
  homepage 'https://acpica.org/'
  version '20200326'
  compatibility 'all'
  source_url 'https://acpica.org/sites/acpica/files/acpica-unix2-20200326.tar.gz'
  source_sha256 '7e0d38d088ff4b2114d08e76201e000091d5a4af40ce7275950759299ba10878'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200326-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200326-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200326-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/acpica-20200326-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41637c5d867042924c95be3436f0a4f072beef461bf469f76e9fe5afd052a693',
     armv7l: '41637c5d867042924c95be3436f0a4f072beef461bf469f76e9fe5afd052a693',
       i686: '8c1b85fb9a48bfb2d2b9a27e8fff2805a115e637a8e5bf8a97ca7e982bdfd883',
     x86_64: '9a9b44aa60bb4718513ffe3e6531011bceee6baa713e171810578666e1a3a393',
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
