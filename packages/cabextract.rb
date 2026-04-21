require 'buildsystems/autotools'

class Cabextract < Autotools
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.11'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.cabextract.org.uk/cabextract-#{version}.tar.gz"
  source_sha256 'b5546db1155e4c718ff3d4b278573604f30dd64c3c5bfd4657cd089b823a3ac6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cf8af8bac1a92655c65158f8bdec79dc42918ac8d76f1fafa3aaf055ad8c6b0',
     armv7l: '6cf8af8bac1a92655c65158f8bdec79dc42918ac8d76f1fafa3aaf055ad8c6b0',
       i686: 'c17e71b9dba34b23265633dc62550c0b71f95b3679c21bf843370a64c5d72aee',
     x86_64: '3c3ab8430290ca29532772c4626685b250ceb58ad5980bd885c1b328dafac0f9'
  })

  depends_on 'glibc' => :executable

  def self.patch
    # The aclocal and automake versions are hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    automake_version = `automake --version|head -1|cut -d' ' -f4`.chomp
    system "sed -i 's,1.16.5,#{automake_version},g' aclocal.m4"
    system "sed -i 's,1.16,#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,1.16,#{aclocal_version},g' configure"
  end

  run_tests
end
