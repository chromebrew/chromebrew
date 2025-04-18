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
    aarch64: '3fcd388f8f8fba58e2aa3a15377b782bb2aa6412ba090bdf5b9da00fdae723e3',
     armv7l: '3fcd388f8f8fba58e2aa3a15377b782bb2aa6412ba090bdf5b9da00fdae723e3',
       i686: '0b01a7b5429b74a165642d83b8f7b06115182338c7483c47987c1ba318dd3332',
     x86_64: '80c71c2cda3045d6c94b4fb298833b647001dc519c5f60e819bbb50b41a022a9'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
