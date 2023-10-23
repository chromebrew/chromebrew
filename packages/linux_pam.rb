require 'package'

class Linux_pam < Package
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.5.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam/releases/download/v1.5.3/Linux-PAM-1.5.3.tar.xz'
  source_sha256 '7ac4b50feee004a9fa88f1dfd2d2fa738a82896763050cd773b3c54b0a818283'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.3_armv7l/linux_pam-1.5.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.3_armv7l/linux_pam-1.5.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.3_i686/linux_pam-1.5.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_pam/1.5.3_x86_64/linux_pam-1.5.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a371c602ab5519c0d9322f70fe317b3033b5ba1175ba02ab645d87c09fd4a1f9',
     armv7l: 'a371c602ab5519c0d9322f70fe317b3033b5ba1175ba02ab645d87c09fd4a1f9',
       i686: '9410659381a17e918433e2fd6aeeac57ebc7143de46499ce206c2f71d691c59d',
     x86_64: '42470ad49611a6ec7c9d18d61cef06c490ba5224c888394a19762be2afcf470a'
  })

  depends_on 'glibc' # R
  depends_on 'libdb' # libdb needs to be built with "--enable-dbm"
  depends_on 'libeconf' # R

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
