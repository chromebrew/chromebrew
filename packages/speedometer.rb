require 'package'

class Speedometer < Package
  description 'Measure and display the rate of data across a network connection or data being stored in a file.'
  homepage 'https://excess.org/speedometer/'
  version '2.9-0.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://httpredir.debian.org/debian/pool/main/s/speedometer/speedometer_#{version}_all.deb"
  source_sha256 'bdf67873fa613510169c89d44f43aa637bc36891c719df5a1fbc4badee0b3f85'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26e1b68b779890cfe9f451362732e5e83ac5401aedf2ce72ef3e2dc69c647b2c',
     armv7l: '26e1b68b779890cfe9f451362732e5e83ac5401aedf2ce72ef3e2dc69c647b2c',
       i686: '8fefc40adc19044d71f3fdb4705d5f79cc6c43bbb6ced41cb05d065480bef981',
     x86_64: '07e7e6b7b052490b50e08bb0f5b97cedf87623e5e90e00e08f0f173b99046462'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_nuitka' => :build
  depends_on 'py3_psutil' => :executable
  depends_on 'py3_six' => :executable
  depends_on 'py3_urwid' => :executable
  depends_on 'python3' => :executable

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
    FileUtils.install 'bin/speedometer', "#{CREW_DEST_PREFIX}/bin/speedometer", mode: 0o755
    FileUtils.install 'share/man/man1/speedometer.1', "#{CREW_DEST_MAN_PREFIX}/man1/speedometer.1", mode: 0o644
  end
end
