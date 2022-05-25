require 'package'

class Shadow < Package
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  version '4.13'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://github.com/shadow-maint/shadow/releases/download/#{version}/shadow-#{version}.tar.xz"
  source_sha256 '9afe245d79a2e7caac5f1ed62519b17416b057ec89df316df1c3935502f9dd2c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shadow/4.13_armv7l/shadow-4.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shadow/4.13_armv7l/shadow-4.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shadow/4.13_i686/shadow-4.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shadow/4.13_x86_64/shadow-4.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ce09c87fd90b9751c7f47be22d835490685f41f0fd4af484a7e06184115176e2',
     armv7l: 'ce09c87fd90b9751c7f47be22d835490685f41f0fd4af484a7e06184115176e2',
       i686: '09ea3f8487715d726dd822d921f6e1206e49e2e98ca8e5fd3d09e1933d6ce4f5',
     x86_64: '3074d0d8cbfb2d807d5e5e9993a2429ac43391a085eadbcd95a9ed12ceeb391a'
  })

  depends_on 'linux_pam'
  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'libeconf' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --bindir=#{CREW_PREFIX}/bin \
      --sbindir=#{CREW_PREFIX}/bin \
      --enable-shared \
      --with-libpam \
      --without-selinux \
      --with-acl \
      --with-attr \
      --disable-nls \
      --enable-subordinate-ids \
      --disable-account-tools-setuid"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    # Handle conflicts with coreutils.
    @conflicts = %w[login su chfn chsh groups]
    @conflicts.each do |conflict_file|
      FileUtils.mv "#{CREW_DEST_PREFIX}/bin/#{conflict_file}", "#{CREW_DEST_PREFIX}/bin/shadow_#{conflict_file}"
    end
  end
end
