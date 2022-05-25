require 'package'

class Speedometer < Package
  description 'Measure and display the rate of data across a network connection or data being stored in a file.'
  homepage 'https://excess.org/speedometer/'
  version '2.8-3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/s/speedometer/speedometer_2.8-3_all.deb'
  source_sha256 '63e676c96a9df953b4f7f631f1c1d21fedd71d23d159b53e60662c6bb4c19437'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedometer/2.8-3_armv7l/speedometer-2.8-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedometer/2.8-3_armv7l/speedometer-2.8-3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedometer/2.8-3_i686/speedometer-2.8-3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedometer/2.8-3_x86_64/speedometer-2.8-3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6f3e7d29fde57f37d0f0ea595374166701b30a6153b932c25ced4be683d27edf',
     armv7l: '6f3e7d29fde57f37d0f0ea595374166701b30a6153b932c25ced4be683d27edf',
       i686: '8a7b3a69c6369867b7ac6443f080862450d2923df6fbc7a22be797ab33958f45',
     x86_64: 'a926e76ca2d5de7773b2e2d5423892677c020f0b1328abe9ff84fe81d2801a97'
  })

  depends_on 'py3_psutil'
  depends_on 'py3_six'
  depends_on 'py3_nuitka' => :build

  def self.patch
    system "sed -i 's:#!/usr/bin/python3:#!#{CREW_PREFIX}/bin/python3:' bin/speedometer"
  end

  def self.build
    FileUtils.mv 'bin/speedometer', 'bin/speedometer.py'
    system "python3 -m nuitka --show-progress \
            --show-scons \
            --follow-imports \
            --prefer-source-code \
            bin/speedometer.py \
            -o bin/speedometer"
    system 'gunzip share/man/man1/speedometer.1.gz'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.cp 'bin/speedometer', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp 'share/man/man1/speedometer.1', "#{CREW_DEST_MAN_PREFIX}/man1/"
  end
end
