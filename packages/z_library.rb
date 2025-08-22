require 'package'

class Z_library < Package
  description 'Z-Library launcher for desktop'
  homepage 'https://z-lib.fm/z-access#desktop_app_tab'
  version '2.4.3'
  license 'Apache-2.0, BSD, MIT, others'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url 'https://s3proxy.cdn-zlib.sk/te_public_files/soft/linux/zlibrary-setup-latest.tar.gz'
  source_sha256 '56d448202c72ea5db733a76265227fd52295c095d6ac865d34ef5b1f80d0ee4b'

  depends_on 'gtk3'

  no_compile_needed

  def self.build
    File.write 'z-library.sh', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/z-library:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/z-library
      ./z-library "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/z-library"
    FileUtils.install 'z-library.sh', "#{CREW_DEST_PREFIX}/bin/z-library", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/z-library"
  end

  def self.postinstall
    ExitMessage.add "\nType 'z-library' to get started.\n"
  end
end
