require 'buildsystems/autotools'

class Linux_pam < Autotools
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.7.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam.git'
  git_hashtag "Linux-PAM-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a371c602ab5519c0d9322f70fe317b3033b5ba1175ba02ab645d87c09fd4a1f9',
     armv7l: 'a371c602ab5519c0d9322f70fe317b3033b5ba1175ba02ab645d87c09fd4a1f9',
       i686: '9410659381a17e918433e2fd6aeeac57ebc7143de46499ce206c2f71d691c59d',
     x86_64: '42470ad49611a6ec7c9d18d61cef06c490ba5224c888394a19762be2afcf470a'
  })

  depends_on 'glibc' # R
  depends_on 'libdb' # libdb needs to be built with "--enable-dbm"
  depends_on 'libeconf' # R

  autotools_configure_options '--disable-selinux \
      --enable-static \
      --disable-nis'

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/security"
    Dir.chdir "#{CREW_DEST_PREFIX}/include" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/include/{} #{CREW_DEST_PREFIX}/include/security/{} \\;"
    end
  end
end
