require 'buildsystems/meson'

class Linux_pam < Meson
  description 'Linux PAM (Pluggable Authentication Modules for Linux) project'
  homepage 'https://github.com/linux-pam/linux-pam'
  version '1.7.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/linux-pam/linux-pam.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecaf3ad1366d24e6c69336f11db2c57898dfc4c87635361567957b3e6e41ce62',
     armv7l: 'ecaf3ad1366d24e6c69336f11db2c57898dfc4c87635361567957b3e6e41ce62',
       i686: 'c6a3ccf3fe424733831c77ce133c189aa0bff604bbda60415fcff0ae9e243162',
     x86_64: '1065007b54ae04203d86d86cbd23e43245cbe26014fec7d9664045148bf5fec5'
  })

  depends_on 'gdbm' => :library
  depends_on 'glibc' => :library
  depends_on 'libeconf' => :library
  depends_on 'libxcrypt' => :logical

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
