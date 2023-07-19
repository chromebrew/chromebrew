require 'package'

class Ltrace < Package
  description 'ltrace intercepts and records dynamic library calls which are called by an executed process and the signals received by that process.'
  homepage 'https://www.ltrace.org/'
  version '0.7.91-ea8928'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/cespedes/ltrace.git'
  git_hashtag 'ea8928dab8a0a1f549d0ed8ebc6ec563e9fa1159'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ltrace/0.7.91-ea8928_armv7l/ltrace-0.7.91-ea8928-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ltrace/0.7.91-ea8928_armv7l/ltrace-0.7.91-ea8928-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ltrace/0.7.91-ea8928_i686/ltrace-0.7.91-ea8928-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ltrace/0.7.91-ea8928_x86_64/ltrace-0.7.91-ea8928-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '09bc63d26ef561e10f01628d61eb4a6c8d5caeb24a77f19deddb5fa1a5867dd2',
     armv7l: '09bc63d26ef561e10f01628d61eb4a6c8d5caeb24a77f19deddb5fa1a5867dd2',
       i686: 'fc5ca046f26608668f2885a0389d47baf7fea535503366c79464bb9c0014873d',
     x86_64: '69ce6519d523f4b225e28f421f766c4f502a0e970e093a1d3beba117904898a7'
  })

  depends_on 'libunwind'
  depends_on 'procps'

  def self.patch
    # Use readdir instead of deprecated readdir_r.
    # This patch can be removed after the merge request is merged.
    system 'curl -L#O https://gitlab.com/cespedes/ltrace/-/merge_requests/1.diff'
    abort 'Checksum mismatch. 😔 Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('1.diff')) == '77442c497bd8410e0afba3a03638a6504ed9ae216bd694a771682f592a9c3759'
    system 'patch -p1 < 1.diff'
  end

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} --disable-werror --without-elfutils --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
