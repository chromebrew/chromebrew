require 'package'

class Linux_pam < Package
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.5.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam/releases/download/v1.5.1/Linux-PAM-1.5.1.tar.xz'
  source_sha256 '201d40730b1135b1b3cdea09f2c28ac634d73181ccd0172ceddee3649c5792fc'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/linux_pam-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/linux_pam-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/linux_pam-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/linux_pam-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50f55a3858081ca4748fba9f731310b81c9ed6ed85597c1fd715a5c2ae1f56d4',
     armv7l: '50f55a3858081ca4748fba9f731310b81c9ed6ed85597c1fd715a5c2ae1f56d4',
       i686: '5017e846407cb9692a915b1b513616515a45a6143303904125d29f0a43348ab6',
     x86_64: 'af1b7e6212444ba310b0441a5f32697f6478a1b62f79b78153fd49718a4e8465',
  })

  depends_on 'libdb' # libdb needs to be built with "--enable-dbm"

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-static --disable-nis"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/security"
    Dir.chdir "#{CREW_DEST_PREFIX}/include" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/include/{} #{CREW_DEST_PREFIX}/include/security/{} \\;"
    end
  end
end
