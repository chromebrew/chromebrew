require 'package'

class Libcue < Package
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.2.1'
  version "#{@_ver}-1"
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-1_armv7l/libcue-2.2.1-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-1_armv7l/libcue-2.2.1-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-1_i686/libcue-2.2.1-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-1_x86_64/libcue-2.2.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d8289b34f20ccad9051d5588888b3236c002aecd077138d1d468ce85d0b84c7',
      armv7l: '0d8289b34f20ccad9051d5588888b3236c002aecd077138d1d468ce85d0b84c7',
        i686: '8d2821a6059b805cfc7789ccde5f769c6e86c4c04b99ca96647e8e82f81d8541',
      x86_64: '3c63b508f9b104d76317bb62b291746bc692d57dabcf3e806d8be736f69971d3'
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
