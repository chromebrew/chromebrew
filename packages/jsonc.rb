require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.16-1741bcd'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag '1741bcd3eaf2603b8256735560de9b0d3244d62f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-1741bcd_armv7l/jsonc-0.16-1741bcd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-1741bcd_armv7l/jsonc-0.16-1741bcd-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-1741bcd_i686/jsonc-0.16-1741bcd-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-1741bcd_x86_64/jsonc-0.16-1741bcd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5bc684f839c15992a90ee87bfce2b982897cb991ad0e63aecccb193a73705bb4',
     armv7l: '5bc684f839c15992a90ee87bfce2b982897cb991ad0e63aecccb193a73705bb4',
       i686: 'e1becda31e7af8b56b106df854b6c6b4722bc67a5cd7ddac970a66f8ea55f263',
     x86_64: 'e0926875fa85dce385118551f8294d5a4e7455171a49818bab9c9b8040bc8c06'
  })

  depends_on 'glibc' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
