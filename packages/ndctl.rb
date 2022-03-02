require 'package'

class Ndctl < Package
  description 'Helper tools and libraries for managing the libnvdimm (non-volatile memory device) sub-system in the Linux kernel'
  homepage 'https://github.com/pmem/ndctl'
  version 'v72.1'    
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/pmem/ndctl/archive/refs/tags/v72.1.tar.gz'
  source_sha256 '9059ee4b129730604cee6aba7a8bc207b6e9aa6466b6da9b3b29d1996bf3712a'

  depends_on 'asciidoctor' => :build
  depends_on 'bash_completion' => :build
  depends_on 'iniparser' => :build
  depends_on 'jsonc' => :build
  depends_on 'keyutils' => :build
  depends_on 'xmlto' => :build
  
  def self.build
    system "./autogen.sh"
    system "./configure CFLAGS='-g -O2' #{CREW_OPTIONS} --without-systemd"
    system "make"
  end

  def self.check
    system 'make check'
  end
 
  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
