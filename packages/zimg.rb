require 'package'

class Zimg < Package
  version '5.0.0'
  source_url 'https://downloads.sourceforge.net/project/zimg/zimg/zimg-5.0.0/zimg-5.0.0.tar.gz'
  source_sha1 'f263e6629a7eadd0e32ac13e3380afd7238f944e'

  depends_on 'libgd'

  def self.build
    #system "sed -i '/^    zimg_t z;/d' zimg.c"
    #system "sed -i 's/if (z\.fontspec/if (z.fontspec != null/g' zimg.c"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
