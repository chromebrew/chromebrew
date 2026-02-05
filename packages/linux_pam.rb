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
    aarch64: 'a01010ccd68fe7cd022052d5bb4136d5e72ffd7d4897990b3133c386f65ba145',
     armv7l: 'a01010ccd68fe7cd022052d5bb4136d5e72ffd7d4897990b3133c386f65ba145',
       i686: '4236d1bd3642aeb129a00813416fd2cbbaac9d188bbf3f2fbdaa4706ac85daea',
     x86_64: '9bb1165900b6bf5be8fac459ce3cee8f07c9b271dcae514a23f64ecd7dffcb3e'
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
