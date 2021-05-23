require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.0.5'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop/archive/refs/tags/3.0.5.tar.gz'
  source_sha256 '4c2629bd50895bd24082ba2f81f8c972348aa2298cc6edc6a21a7fa18b73990c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/htop/3.0.5_armv7l/htop-3.0.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/htop/3.0.5_armv7l/htop-3.0.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/htop/3.0.5_i686/htop-3.0.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/htop/3.0.5_x86_64/htop-3.0.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d41a8aebc631c10aece2fe14fd1762bdeabaef59347af6e7e1e88b3cdabb5b4',
     armv7l: '0d41a8aebc631c10aece2fe14fd1762bdeabaef59347af6e7e1e88b3cdabb5b4',
       i686: '25835e8c7455192d539682ae269cd20e1accf6103d31f355f4a29cbcb215a646',
     x86_64: 'ae62201f3496fd3b64c94002af594c9650f3e345ed34db7f1d9d04d667e03d5c'
  })

  depends_on 'buildessential' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw' \
      ./configure #{CREW_OPTIONS} \
      --disable-unicode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
