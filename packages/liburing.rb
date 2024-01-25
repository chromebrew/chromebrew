require 'package'

class Liburing < Package
  description 'liburing provides helpers to setup and teardown io_uring instances.'
  homepage 'https://github.com/axboe/liburing/'
  version '2.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/axboe/liburing/archive/refs/tags/liburing-#{version}.tar.gz"
  source_sha256 'ca069ecc4aa1baf1031bd772e4e97f7e26dfb6bb733d79f70159589b22ab4dc0'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '25bda02208eb872e11c8434523056bb3591996aa6aec935171c5ce81bcb39225',
     armv7l: '25bda02208eb872e11c8434523056bb3591996aa6aec935171c5ce81bcb39225',
       i686: 'd6cdacf0351d2d301d5827b8413768489d2dd6d53fe8d94978ba2d1f1af9ac29',
     x86_64: '960697d65213698aaff0457b536a5ef6d8f45a5614fb3752c0fb572fded4077c'
  })

  def self.patch
    # system "sed -i '/<unistd.h>/a #include <asm/unistd.h>' test/fc2a85cb02ef-test.c"
    # system "sed -i '/<unistd.h>/a #include <asm/unistd.h>' test/double-poll-crash.c"
  end

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS.sub(/--build=.*/, '')}"
    system 'make -C src'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
