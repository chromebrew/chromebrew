require 'package'

class Libprelude < Package
  description 'Prelude is a Universal "Security Information & Event Management" (SIEM) system.'
  homepage 'https://www.prelude-siem.org/'
  version '4.1.0'
  source_url 'https://www.prelude-siem.org/attachments/download/831/libprelude-4.1.0.tar.gz'
  source_sha256 '21ee5bee2fc4136903c606ad7891927b7b32a29e92ca7e418ac458823951562d'

  depends_on 'python27' => :build    
  depends_on 'python3' => :build
    
  def self.build
      system "./configure \
               --prefix=#{CREW_PREFIX} \
               --libdir=#{CREW_LIB_PREFIX}"      
  end

  def self.install
      system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
