require 'package'

class Libva_intel_driver_hybrid < Package
  description 'VA-API implementation for Intel G45 and HD Graphics family'
  homepage 'https://github.com/intel/intel-vaapi-driver'
  version '2.4.1-1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/intel-vaapi-driver/archive/2.4.1.tar.gz'
  source_sha256 '03cd7e16acc94f828b6e7f3087863d8ca06e99ffa3385588005b1984bdd56157'
  binary_compression 'tar.xz'

  binary_sha256({
    x86_64: 'e9c740a0bd917ecbb69b822ce9df1609f415776ab5a5e553eb0a83bc93a35f90'
  })

  depends_on 'igt_gpu_tools'

  def self.patch
    # Only relevant if intel-gpu-tools is installed,
    # since then the shaders will be recompiled
    system "sed -i '1s/python\$/&2/' src/shaders/gpp.py"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            -Denable_hybrid_codec=true builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # libva_intel_driver_hybrid configuration
      export LIBVA_DRIVER_NAME=i965
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/libva_intel_driver_hybrid", @env)
  end
end
