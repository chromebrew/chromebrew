require 'package'

class Linux_pam < Package
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.5.2'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam/releases/download/v1.5.2/Linux-PAM-1.5.2.tar.xz'
  source_sha256 'e4ec7131a91da44512574268f493c6d8ca105c87091691b8e9b56ca685d4f94d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.2_armv7l/linux_pam-1.5.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.2_armv7l/linux_pam-1.5.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.2_i686/linux_pam-1.5.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.2_x86_64/linux_pam-1.5.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fdf87dc40abeb0525e3026d68979b17210cc5a991fe9056e83f9c6b5c8ea3ba9',
     armv7l: 'fdf87dc40abeb0525e3026d68979b17210cc5a991fe9056e83f9c6b5c8ea3ba9',
       i686: '74f51ebb2dfddf54317bb2fab540688373f62dcb334cf3e3a30de0b323cd79db',
     x86_64: '81a43a40a39d742a56fc74716e91098f4497c5f1b1f702de0791bdf6fe5e95aa'
  })

  depends_on 'glibc' # R
  depends_on 'libdb' # libdb needs to be built with "--enable-dbm"

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --disable-selinux \
      --enable-static \
      --disable-nis"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/security"
    Dir.chdir "#{CREW_DEST_PREFIX}/include" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/include/{} #{CREW_DEST_PREFIX}/include/security/{} \\;"
    end
  end
end
