require 'package'

class Speedometer < Package
  description 'Measure and display the rate of data across a network connection or data being stored in a file.'
  homepage 'https://excess.org/speedometer/'
  version '2.8-3-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/s/speedometer/speedometer_2.8-3_all.deb'
  source_sha256 '63e676c96a9df953b4f7f631f1c1d21fedd71d23d159b53e60662c6bb4c19437'

  depends_on 'py3_psutil'
  depends_on 'six'
  depends_on 'py3_nuitka' => :build

  def self.patch
    system "sed -i 's:#!/usr/bin/python3:#!#{CREW_PREFIX}/bin/python3:' bin/speedometer"
  end

  def self.build
    FileUtils.mv "bin/speedometer", "bin/speedometer.py"
    system "python3 -m nuitka \
            --follow-imports \
            --prefer-source-code \
            bin/speedometer.py \
            -o bin/speedometer"
    system "gunzip share/man/man1/speedometer.1.gz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install "bin/speedometer", "#{CREW_DEST_PREFIX}/bin/", mode: 0755
    FileUtils.install "share/man/man1/speedometer.1", "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0644
  end
end
