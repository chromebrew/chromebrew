require 'package'

class Musl_obstack < Package
  description 'Void Linux copy + paste of the obstack functions and macros found in GNU gcc libiberty library for use with musl libc'
  homepage 'https://github.com/void-linux/musl-obstack'
  version '1.2.2'
  license 'zlib'
  compatibility 'all'
  source_url 'https://github.com/void-linux/musl-obstack.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_obstack/1.2.2_armv7l/musl_obstack-1.2.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_obstack/1.2.2_armv7l/musl_obstack-1.2.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_obstack/1.2.2_i686/musl_obstack-1.2.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_obstack/1.2.2_x86_64/musl_obstack-1.2.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fcfd3b87dcb48cc7d4798e7af325a185a242e7c90d8776e833a1eb8cca1c3567',
     armv7l: 'fcfd3b87dcb48cc7d4798e7af325a185a242e7c90d8776e833a1eb8cca1c3567',
       i686: '1673a62c62cde7e1d8628fd181a0495521fc0b87c7545846927ed8ccef42256a',
     x86_64: 'c3ceef174bdf36800ab62e187e11b9a5d37d51e9a0674eb9caf769f4cdbc74d3'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./bootstrap.sh"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX}"
    system "#{MUSL_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
