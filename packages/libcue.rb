require 'package'

class Libcue < Package
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.2.1'
  version "#{@_ver}-2"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-2_armv7l/libcue-2.2.1-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-2_armv7l/libcue-2.2.1-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-2_i686/libcue-2.2.1-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-2_x86_64/libcue-2.2.1-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7280f4c8791036ff19b4f7c66247a4061bdbcf1174c462b6514ddf9d595f246d',
     armv7l: '7280f4c8791036ff19b4f7c66247a4061bdbcf1174c462b6514ddf9d595f246d',
       i686: 'ff73b593cb5b157df293efbba4eda3aace6ccf3f8ff7a65501e06d3114d96f5f',
     x86_64: '643d18797d75d95900d74fe3287f92f3273019b6221b503fa0cb4abecc632269'
  })

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
