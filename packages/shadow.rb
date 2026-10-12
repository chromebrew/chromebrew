require 'buildsystems/autotools'

class Shadow < Autotools
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  version '4.20.3'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/shadow-maint/shadow.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fee392adce459c9a2cf88d66cd9aae0b75bc55a224c751b8b951b2c50d904058',
     armv7l: 'fee392adce459c9a2cf88d66cd9aae0b75bc55a224c751b8b951b2c50d904058',
       i686: '38c3e34d89ecd5cbc984b176a0a95949df9da9bb235f82bddba0b31478a1d255',
     x86_64: '5330236fc0ec2120174b2131d4837156f813cea9167aaf28c0d3971035f1eb28'
  })

  depends_on 'acl' => :library
  depends_on 'attr' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libeconf' => :library
  depends_on 'libmd' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'libxslt' => :executable
  depends_on 'linux_pam' => :library

  autotools_skip_configure

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh || true'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} \
      --#{ARCH.eql?('x86_64') ? 'enable' : 'disable'}-year2038 \
      --disable-logind \
      --disable-static \
      --enable-shared \
      --with-libpam \
      --without-selinux \
      --with-acl \
      --disable-nls \
      --enable-subordinate-ids"
    system 'make'
  end

  autotools_install_extras do
    # Handle conflicts.
    @conflicts = %w[login su chfn chsh groups newgrp]
    @conflicts.each do |conflict_file|
      next unless File.file?("#{CREW_DEST_PREFIX}/bin/#{conflict_file}")

      FileUtils.mv "#{CREW_DEST_PREFIX}/bin/#{conflict_file}", "#{CREW_DEST_PREFIX}/bin/shadow_#{conflict_file}"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/sbin/nologin", "#{CREW_DEST_PREFIX}/sbin/shadow_nologin"
  end
end
