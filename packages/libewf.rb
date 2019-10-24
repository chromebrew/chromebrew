require 'package'

class Libewf < Package
  description 'Libewf is a library to access the Expert Witness Compression Format (EWF)'
  homepage 'https://github.com/libyal/libewf'
  version '20140608'
  source_url 'https://github.com/libyal/libewf/releases/download/20171104/libewf-experimental-20171104.tar.gz'
  source_sha256 'cf36d3baf3a96dbe566fde55ae7d79fc2e7b998806ab13e0f69915799f19e040'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
