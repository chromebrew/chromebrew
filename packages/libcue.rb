require 'buildsystems/cmake'

class Libcue < CMake
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.2.1'
  version "#{@_ver}-4"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-4_armv7l/libcue-2.2.1-4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-4_armv7l/libcue-2.2.1-4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-4_i686/libcue-2.2.1-4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.2.1-4_x86_64/libcue-2.2.1-4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '76ad8451342a57dd7548218e7c38e4c2f920cf5fb42e4a960af3f1087c6af5d1',
     armv7l: '76ad8451342a57dd7548218e7c38e4c2f920cf5fb42e4a960af3f1087c6af5d1',
       i686: '9930944eff65deda582302b2297b91e5d98c475e190b517170436081822ccf1d',
     x86_64: '094867b36a144609576018b3ff71cfab8dc92c4c89c6d96fc5af41184ce1b449'
  })

  depends_on 'glibc' # R

  def self.patch
    # CVE-2023-43641.patch from Arch at
    # https://gitlab.archlinux.org/archlinux/packaging/packages/libcue/-/blob/main/CVE-2023-43641.patch?ref_type=heads
    puts 'Patching for CVE-2023-43641.'.orange
    system "sed -i 's,if (i > MAXINDEX) {,if (i < 0 || i > MAXINDEX) {,' cd.c"
  end

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
