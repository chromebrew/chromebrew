require 'package'

class Libvoamrwbenc < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.3-0'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz'
  source_sha256 '5652b391e0f0e296417b841b02987d3fd33e6c0af342c69542cbb016a71d9d4e'



  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
