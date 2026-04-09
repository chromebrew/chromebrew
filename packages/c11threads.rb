require 'package'

class C11threads < Package
  description 'Trivial C11 threads.h implementation over POSIX threads'
  homepage 'https://github.com/jtsiomb/c11threads'
  version '2.0'
  max_glibc '2.30'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/jtsiomb/c11threads.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '222deff81600390a763f62ddab5793947810464e713a4747f65935076e8a78bd',
     armv7l: '222deff81600390a763f62ddab5793947810464e713a4747f65935076e8a78bd',
       i686: '97f73194b454290dbe96d203c343b3ae122f2a1b8a10854e10835fb35f893145',
     x86_64: '940583a703a900893295ff1b0217b5837218250a7957ed415022eb5cf04af487'
  })

  def self.install
    FileUtils.install 'c11threads.h', "#{CREW_DEST_PREFIX}/include/threads.h", mode: 0o644
  end
end
