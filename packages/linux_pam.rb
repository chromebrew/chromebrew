require 'buildsystems/meson'

class Linux_pam < Meson
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.7.2'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25974e63f145c719db4482024036ef10cad4ad92bb72504d728555cd346f3b86',
     armv7l: '25974e63f145c719db4482024036ef10cad4ad92bb72504d728555cd346f3b86',
       i686: '0f7adeca7bd53900c4ff9ed394b00acb20a8a9fdaad0216f492eca0478f3dd8e',
     x86_64: '65471b0ba28790f677b701e6b44fe735e768ba2087d5b3a35fb194a8a97e45d7'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'libeconf' # R
  depends_on 'libxcrypt' # R

  no_mold

  meson_options '-Ddb=gdbm \
      -Ddocs=disabled \
      -Dselinux=disabled \
      -Dnis=disabled'

  meson_build_extras do
    # We need to move libcrypt.so out of the way so libxcrypt is used.
    FileUtils.mv "#{CREW_LIB_PREFIX}/libcrypt.so.bak", "#{CREW_LIB_PREFIX}/libcrypt.so" if File.file? "#{CREW_LIB_PREFIX}/libcrypt.so.bak"
  end

  def self.prebuild
    # We need to move libcrypt.so out of the way so libxcrypt is used.
    FileUtils.mv "#{CREW_LIB_PREFIX}/libcrypt.so", "#{CREW_LIB_PREFIX}/libcrypt.so.bak" if File.file? "#{CREW_LIB_PREFIX}/libcrypt.so"
  end
end
