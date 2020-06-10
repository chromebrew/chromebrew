require 'package'

class Linux_pam < Package
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.3.1'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam/releases/download/v1.3.1/Linux-PAM-1.3.1.tar.xz'
  source_sha256 'eff47a4ecd833fbf18de9686632a70ee8d0794b79aecb217ebd0ce11db4cd0db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/linux_pam-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/linux_pam-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/linux_pam-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/linux_pam-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa843f1976fe0305311b857ff803945c40d1953edb191333f7f258924585aff7',
     armv7l: 'fa843f1976fe0305311b857ff803945c40d1953edb191333f7f258924585aff7',
       i686: '166142b8ccd0b24b39d7c6e0105d94b3a9eb7cb66af2a5b702024c5c0fcb9a5a',
     x86_64: 'f2536e7e91c5154744e78630dc53d3ce767c00baf05d0fa998f15f848b6dc561',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-static'
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
