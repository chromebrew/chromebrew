require 'package'

class Libcue < Package
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.2.1'
  version "#{@_ver}-3"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-3_armv7l/libcue-2.2.1-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-3_armv7l/libcue-2.2.1-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-3_i686/libcue-2.2.1-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-3_x86_64/libcue-2.2.1-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '59e82a71c1709c6549556edbf3a165c6514c552fbd094dbdbbb1bd12da8626ba',
     armv7l: '59e82a71c1709c6549556edbf3a165c6514c552fbd094dbdbbb1bd12da8626ba',
       i686: '0a30d2b87104637f19aef5aa24f9130e794029b13c9f12f89313a9204e1d9c29',
     x86_64: '8649bbcefec967a29b2eb3f96fa86c129c52c577b04ac50148e11c549ab46c37'
  })

  depends_on 'glibc' # R

  def self.build
    system "cmake -B builddir -G 'Ninja' \
      #{CREW_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=ON"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test"
  end
end
