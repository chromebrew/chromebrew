require 'buildsystems/meson'

class Pcsc_lite < Meson
  description 'PCSC is middleware to access a smart card using SCard API (PC/SC).'
  homepage 'https://pcsclite.apdu.fr/'
  version '2.5.4'
  compatibility 'aarch64 armv7l x86_64'
  license 'BSD, ISC, MIT, GPL-3+ and GPL-2'
  source_url 'https://salsa.debian.org/debian/pcsc-lite.git'
  git_hashtag "debian/#{version}-1"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0f830b3fb155708b0572eb3989a6f04ae08c7b2ee58d6ddc38a608c4f12ee6d',
     armv7l: 'a0f830b3fb155708b0572eb3989a6f04ae08c7b2ee58d6ddc38a608c4f12ee6d',
     x86_64: '9ee0812ef0aec1e959f70327dabc885184ddb65290086c8adf43cc8491eb6a30'
  })

  depends_on 'elogind'
  depends_on 'eudev' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'polkit' => :executable

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  meson_options "-Dlibsystemd=false -Dlibusb=false -Dlibudev=true -Dpolkit=true \
    -Dusb=true -Dserial=true -Dserialconfdir=#{CREW_PREFIX}/etc/reader.conf.d \
    -Dusbdropdir=#{CREW_LIB_PREFIX}/pcsc/drivers -Dipcdir=#{CREW_PREFIX}/var/run/pcscd"

  meson_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/sysusers.d", "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/systemd", CREW_DEST_LIB_PREFIX.to_s if ARCH.eql?('x86_64')
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' #{CREW_DEST_PREFIX}/bin/pcsc-spy"
  end

  run_tests
end
